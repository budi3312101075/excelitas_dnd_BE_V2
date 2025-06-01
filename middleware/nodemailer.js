import nodemailer from "nodemailer";
import QRCode from "qrcode";

export const sendEmail = async (req, res) => {
  const { email } = req.body;
  const { noEmp } = req.params;

  try {
    const qrOptions = {
      errorCorrectionLevel: "L", //
      margin: 1,
      scale: 10,
    };

    const qrCodeBuffer = await QRCode.toBuffer(String(noEmp), qrOptions);
    console.log(qrCodeBuffer);

    let transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true,
      auth: {
        user: "danaamal5103@gmail.com",
        pass: "xmwn ktwl lbuf psqs",
      },
    });

    let info = await transporter.sendMail({
      from: "danaamal5103@gmail.com",
      to: email,
      subject: "Registration DnD Excelitas",
      html: `
          <h1>Data Registration</h1>
          <p>No Employee : ${noEmp}</p>
          <h2>QR Code:</h2>
          <img src="cid:qrcode" alt="QR Code" />
        `,
      attachments: [
        {
          filename: "qrcode.png",
          content: qrCodeBuffer,
          cid: "qrcode", // same as in img src above
        },
      ],
    });

    console.log(info.messageId);
    console.log(info.accepted);
    console.log(info.rejected);
  } catch (error) {
    console.log(error);
  }
};
