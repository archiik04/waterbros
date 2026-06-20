const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const User = require('../models/User');
const RefreshToken = require('../models/RefreshToken');

class AuthService {
  /**
   * Hash password with bcrypt
   */
  async hashPassword(password) {
    return await bcrypt.hash(password, 10);
  }

  /**
   * Compare password with stored hash
   */
  async comparePassword(password, hashedPassword) {
    return await bcrypt.compare(password, hashedPassword);
  }

  /**
   * Generate access and refresh token pair
   */
  generateTokens(user) {
    const payload = { id: user._id || user.id, email: user.email };
    
    const accessToken = jwt.sign(
      payload,
      process.env.JWT_ACCESS_SECRET,
      { expiresIn: process.env.JWT_ACCESS_EXPIRY }
    );

    const refreshToken = jwt.sign(
      { id: user._id || user.id },
      process.env.JWT_REFRESH_SECRET,
      { 
        expiresIn: process.env.JWT_REFRESH_EXPIRY,
        jwtid: crypto.randomUUID()
      }
    );

    // Calculate refresh token expiry date for DB TTL indexing
    // Default to 7 days if not parsed correctly
    let expiryMs = 7 * 24 * 60 * 60 * 1000;
    const match = process.env.JWT_REFRESH_EXPIRY.match(/^(\d+)([dhm])$/);
    if (match) {
      const value = parseInt(match[1], 10);
      const unit = match[2];
      if (unit === 'd') expiryMs = value * 24 * 60 * 60 * 1000;
      else if (unit === 'h') expiryMs = value * 60 * 60 * 1000;
      else if (unit === 'm') expiryMs = value * 60 * 1000;
    }
    const expiresAt = new Date(Date.now() + expiryMs);

    return { accessToken, refreshToken, expiresAt };
  }

  /**
   * Register a new user
   */
  async registerUser(name, email, password) {
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      const error = new Error('Email is already registered');
      error.statusCode = 400;
      throw error;
    }

    const passwordHash = await this.hashPassword(password);
    const user = new User({
      name,
      email,
      passwordHash,
    });

    await user.save();

    // Generate credentials
    const { accessToken, refreshToken, expiresAt } = this.generateTokens(user);
    
    // Save refresh token to DB
    const dbToken = new RefreshToken({
      token: refreshToken,
      user: user._id,
      expiresAt,
    });
    await dbToken.save();

    return { user, accessToken, refreshToken };
  }

  /**
   * Log in an existing user
   */
  async loginUser(email, password) {
    const user = await User.findOne({ email });
    if (!user) {
      const error = new Error('Invalid email or password');
      error.statusCode = 401;
      throw error;
    }

    const isMatch = await this.comparePassword(password, user.passwordHash);
    if (!isMatch) {
      const error = new Error('Invalid email or password');
      error.statusCode = 401;
      throw error;
    }

    // Generate credentials
    const { accessToken, refreshToken, expiresAt } = this.generateTokens(user);

    // Save refresh token to DB
    const dbToken = new RefreshToken({
      token: refreshToken,
      user: user._id,
      expiresAt,
    });
    await dbToken.save();

    return { user, accessToken, refreshToken };
  }

  /**
   * Refresh and rotate token pair
   */
  async rotateRefreshToken(oldRefreshTokenString) {
    let decoded;
    try {
      decoded = jwt.verify(oldRefreshTokenString, process.env.JWT_REFRESH_SECRET);
    } catch (err) {
      const error = new Error('Invalid or expired refresh token');
      error.statusCode = 401;
      throw error;
    }

    // Look for the token in database
    const tokenRecord = await RefreshToken.findOne({ token: oldRefreshTokenString });

    if (!tokenRecord) {
      // SECURITY BREACH: Token is valid but not in DB (indicates reuse/theft)
      // Revoke all tokens for this user immediately to protect their account
      await RefreshToken.deleteMany({ user: decoded.id });
      
      const error = new Error('Security alert: Refresh token reuse detected. Revoking all access.');
      error.statusCode = 403;
      throw error;
    }

    // Delete the old token
    await tokenRecord.deleteOne();

    // Find the user to generate new tokens
    const user = await User.findById(decoded.id);
    if (!user) {
      const error = new Error('User no longer exists');
      error.statusCode = 401;
      throw error;
    }

    // Generate fresh tokens
    const { accessToken, refreshToken, expiresAt } = this.generateTokens(user);

    // Save the new rotated token
    const newDbToken = new RefreshToken({
      token: refreshToken,
      user: user._id,
      expiresAt,
    });
    await newDbToken.save();

    return { accessToken, refreshToken };
  }

  /**
   * Log out user (revoke single refresh token)
   */
  async logoutUser(refreshTokenString) {
    await RefreshToken.deleteOne({ token: refreshTokenString });
  }
}

module.exports = new AuthService();
