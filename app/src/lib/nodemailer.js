// import nodemailer from 'nodemailer';
const nodemailer = require('nodemailer');
const sendEmailVerify = async (subject, to, html) => {
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'HERE YOUR GMAIL ADRESS',
            pass: 'HERE YOUR GMAIL PASSWORD'
        }
    });
    const mailOptions = {
        from: 'HERE YOUR GMAIL ADDRESS',
        to: to,
        subject: subject,
        html: html,
    };
    await transporter.sendMail(mailOptions);
};

module.exports = sendEmailVerify