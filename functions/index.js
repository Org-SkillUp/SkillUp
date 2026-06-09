const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'luiz.aranhas@souunit.com.br',
    pass: 'tasi pygv vulr ockf'
  }
});

exports.sendEmail = functions.firestore
  .document('mail/{docId}')
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const docId = context.params.docId;

    const mailOptions = {
      from: 'luiz.aranhas@souunit.com.br',
      to: data.to,
      subject: data.message.subject,
      text: data.message.text
    };

    try {
      await transporter.sendMail(mailOptions);
      console.log(`Email enviado para ${data.to}`);
      
      await admin.firestore().collection('mail').doc(docId).delete();
      console.log(`Documento ${docId} deletado`);
    } catch (error) {
      console.error('Erro ao enviar email:', error);
    }
  });