const errorHandler = (err, req, res, next) => {
  let statusCode = err.statusCode || 500;
  let message = err.message || 'Internal Server Error';

  // Log the stack trace internally for developers
  console.error(`[ERROR] ${err.name}: ${err.message}\nStack: ${err.stack}`);

  // Handle Mongoose duplicate key errors (code 11000)
  if (err.code === 11000) {
    statusCode = 400;
    message = 'Email is already registered';
  }

  // Handle Mongoose validation errors
  if (err.name === 'ValidationError') {
    statusCode = 400;
    message = Object.values(err.errors).map((val) => val.message).join(', ');
  }

  // Handle Zod validation issues
  if (err.issues && Array.isArray(err.issues)) {
    statusCode = 400;
    return res.status(400).json({
      success: false,
      message: 'Validation failed',
      errors: err.issues.map((issue) => ({
        field: issue.path.join('.'),
        message: issue.message,
      })),
    });
  }

  res.status(statusCode).json({
    success: false,
    message,
    stack: process.env.NODE_ENV === 'production' ? null : err.stack,
  });
};

module.exports = errorHandler;
