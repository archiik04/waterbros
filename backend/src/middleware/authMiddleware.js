const jwt = require('jsonwebtoken');
const User = require('../models/User');

const protect = async (req, res, next) => {
  let token;

  // Check if header contains Authorization Bearer token
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    try {
      // Get token from header
      token = req.headers.authorization.split(' ')[1];

      // Verify token
      const decoded = jwt.verify(token, process.env.JWT_ACCESS_SECRET);

      // Get user from the token, attach to request object
      req.user = await User.findById(decoded.id).select('-passwordHash');
      
      if (!req.user) {
        return res.status(401).json({
          success: false,
          message: 'User no longer exists',
        });
      }

      next();
    } catch (error) {
      console.error(error);
      
      // Specifically handle token expiry so clients can trigger refresh logic
      if (error.name === 'TokenExpiredError') {
        return res.status(401).json({
          success: false,
          code: 'ACCESS_TOKEN_EXPIRED',
          message: 'Access token has expired',
        });
      }

      return res.status(401).json({
        success: false,
        message: 'Not authorized, invalid token',
      });
    }
  }

  if (!token) {
    return res.status(401).json({
      success: false,
      message: 'Not authorized, no token provided',
    });
  }
};

module.exports = { protect };
