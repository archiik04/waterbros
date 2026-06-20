const crypto = require('crypto');
const authService = require('../services/authService');
const emailService = require('../services/emailService');
const User = require('../models/User');
const {
  registerSchema,
  loginSchema,
  forgotPasswordSchema,
} = require('../validators/authValidator');

/**
 * POST /auth/register
 */
const register = async (req, res, next) => {
  try {
    // Validate request body
    const validatedData = registerSchema.parse(req.body);
    const { name, email, password } = validatedData;

    // Execute service logic
    const result = await authService.registerUser(name, email, password);

    res.status(201).json({
      success: true,
      user: result.user,
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * POST /auth/login
 */
const login = async (req, res, next) => {
  try {
    // Validate request body
    const validatedData = loginSchema.parse(req.body);
    const { email, password } = validatedData;

    // Execute service logic
    const result = await authService.loginUser(email, password);

    res.status(200).json({
      success: true,
      user: result.user,
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * POST /auth/refresh
 */
const refresh = async (req, res, next) => {
  try {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      return res.status(400).json({
        success: false,
        message: 'Refresh token is required',
      });
    }

    // Execute service logic (token rotation)
    const result = await authService.rotateRefreshToken(refreshToken);

    res.status(200).json({
      success: true,
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    });
  } catch (error) {
    next(error);
  }
};

/**
 * POST /auth/logout
 */
const logout = async (req, res, next) => {
  try {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      return res.status(400).json({
        success: false,
        message: 'Refresh token is required',
      });
    }

    // Execute revocation
    await authService.logoutUser(refreshToken);

    res.status(200).json({
      success: true,
      message: 'Logged out successfully',
    });
  } catch (error) {
    next(error);
  }
};

/**
 * POST /auth/forgot-password
 */
const forgotPassword = async (req, res, next) => {
  try {
    // Validate request body
    const validatedData = forgotPasswordSchema.parse(req.body);
    const { email } = validatedData;

    const user = await User.findOne({ email });

    if (user) {
      // Generate a secure reset token
      const resetToken = crypto.randomBytes(20).toString('hex');
      
      // Save token and 1-hour expiry to user document
      user.resetPasswordToken = resetToken;
      user.resetPasswordExpires = Date.now() + 3600000; // 1 hour
      await user.save();

      // Trigger email sending
      await emailService.sendResetPasswordEmail(user.email, resetToken);
    }

    // Security practice: Always return success to prevent account enumeration
    res.status(200).json({
      success: true,
      message: 'If the email matches an active account, password reset instructions have been sent.',
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  register,
  login,
  refresh,
  logout,
  forgotPassword,
};
