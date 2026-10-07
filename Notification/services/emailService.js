const nodemailer = require("nodemailer");
require("dotenv").config();
const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASSWORD
}
});

async function envoyerEmail(destinataire, objet, message) {

    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: destinataire,
        subject: objet,
        text: message
    };
    console.log("EMAIL_USER :", process.env.EMAIL_USER);
console.log("EMAIL_PASSWORD existe :", process.env.EMAIL_PASSWORD);


    await transporter.sendMail(mailOptions);

    console.log("Email envoyé à :", destinataire);
}

module.exports = envoyerEmail;