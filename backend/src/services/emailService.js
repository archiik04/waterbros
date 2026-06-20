class EmailService {
  /**
   * Send reset password instructions
   */
  async sendResetPasswordEmail(email, resetToken) {
    const frontendUrl = process.env.FRONTEND_URL || 'http://localhost:3000';
    const resetUrl = `${frontendUrl}/reset-password?token=${resetToken}`;

    console.log('\n==================================================');
    console.log(`[EMAIL SERVICE] Sending Reset Password Email to: ${email}`);
    console.log(`[EMAIL SERVICE] Click the link to reset your password:`);
    console.log(`[EMAIL SERVICE] ${resetUrl}`);
    console.log('==================================================\n');

    // Production note: In actual deployment, instantiate a transporter here
    // using nodemailer, SendGrid, Amazon SES, or Mailgun:
    //
    // const nodemailer = require('nodemailer');
    // const transporter = nodemailer.createTransport({ ... });
    // await transporter.sendMail({
    //   from: '"WaterBros Support" <support@waterbros.com>',
    //   to: email,
    //   subject: "Password Reset Instructions",
    //   html: `<p>You requested a password reset. Click <a href="${resetUrl}">here</a> to reset it.</p>`
    // });

    return true;
  }
}

module.exports = new EmailService();
