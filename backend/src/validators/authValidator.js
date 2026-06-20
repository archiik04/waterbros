const { z } = require('zod');

// Password complexity helper
const passwordSchema = z.string()
  .min(8, 'Password must be at least 8 characters long')
  .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
  .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
  .regex(/[0-9]/, 'Password must contain at least one number')
  .regex(/[^A-Za-z0-9]/, 'Password must contain at least one special character');

const registerSchema = z.object({
  name: z.string()
    .min(2, 'Name must be at least 2 characters')
    .max(50, 'Name must not exceed 50 characters')
    .trim(),
  email: z.string()
    .email('Invalid email address')
    .trim()
    .toLowerCase(),
  password: passwordSchema,
});

const loginSchema = z.object({
  email: z.string()
    .email('Invalid email address')
    .trim()
    .toLowerCase(),
  password: z.string().min(1, 'Password is required'),
});

const forgotPasswordSchema = z.object({
  email: z.string()
    .email('Invalid email address')
    .trim()
    .toLowerCase(),
});

module.exports = {
  registerSchema,
  loginSchema,
  forgotPasswordSchema,
};
