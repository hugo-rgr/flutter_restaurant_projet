export const VERIFICATION_EMAIL_TEMPLATE = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Verify Your Email</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(to right, #4CAF50, #45a049); padding: 20px; text-align: center;">
    <h1 style="color: white; margin: 0;">Verify Your Email</h1>
  </div>
  <div style="background-color: #f9f9f9; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <p>Hello {username},</p>
    <p>Thank you for signing up! Your verification code is:</p>
    <div style="text-align: center; margin: 30px 0;">
      <span style="font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #4CAF50;">{verificationCode}</span>
    </div>
    <p>Enter this code on the verification page to complete your registration.</p>
    <p>This code will expire in 60 minutes for security reasons.</p>
    <p>If you didn't create an account with us, please ignore this email.</p>
    <p>Best regards,<br>EsgEats' Team</p>
  </div>
  <div style="text-align: center; margin-top: 20px; color: #888; font-size: 0.8em;">
    <p>This is an automated message, please do not reply to this email.</p>
  </div>
</body>
</html>
`;

export const RESERVATION_REJECTED_EMAIL_TEMPLATE = `

<!DOCTYPE html>

<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Réservation refusée</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(to right, #f44336, #d32f2f); padding: 20px; text-align: center;">
    <h1 style="color: white; margin: 0;">Réservation refusée</h1>
  </div>
  <div style="background-color: #f9f9f9; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <p>Bonjour,</p>
    <p>Nous sommes désolés, mais votre demande de réservation pour <strong>O'reilly</strong> le <strong>{reservationDate}</strong> à <strong>{reservationTime}</strong> n’a pas pu être acceptée.</p>
    <p>Il se peut que le restaurant soit complet ou indisponible à cette date.</p>
    <p>Nous vous invitons à choisir un autre créneau sur l'appli<strong> O'reilly</strong>.</p>
    <p>Merci pour votre compréhension,<br>L’équipe O'reilly</p>
  </div>
  <div style="text-align: center; margin-top: 20px; color: #888; font-size: 0.8em;">
    <p>Ce message est automatique, merci de ne pas y répondre.</p>
  </div>
</body>
</html>
`;


export const RESERVATION_ACCEPTED_EMAIL_TEMPLATE = `

<!DOCTYPE html>

<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Réservation confirmée</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(to right, #4CAF50, #45a049); padding: 20px; text-align: center;">
    <h1 style="color: white; margin: 0;">Réservation confirmée</h1>
  </div>
  <div style="background-color: #f9f9f9; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <p>Bonjour,</p>
    <p>Bonne nouvelle ! Votre réservation pour <strong>O'reilly</strong> le <strong>{reservationDate}</strong> à <strong>{reservationTime}</strong> a été <strong>acceptée</strong>.</p>
    <p>Nous avons hâte de vous accueillir !</p>
    <p>Si vous souhaitez modifier ou annuler votre réservation, vous pouvez le faire directement depuis l'appli mobile.</p>
    <p>Merci pour votre confiance,<br>L’équipe O'reilly</p>
  </div>
  <div style="text-align: center; margin-top: 20px; color: #888; font-size: 0.8em;">
    <p>Ce message est automatique, merci de ne pas y répondre.</p>
  </div>
</body>
</html>
`;


export const RESERVATION_REQUEST_EMAIL_TEMPLATE = `

<!DOCTYPE html>

<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Demande de réservation reçue</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(to right, #2196F3, #1976D2); padding: 20px; text-align: center;">
    <h1 style="color: white; margin: 0;">Demande de réservation reçue</h1>
  </div>
  <div style="background-color: #f9f9f9; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <p>Bonjour,</p>
    <p>Nous avons bien reçu votre demande de réservation pour <strong>O'reilly</strong> le <strong>{reservationDate}</strong> à <strong>{reservationTime}</strong>.</p>
    <p>Un manager va examiner votre demande et vous répondra très bientôt.</p>
    <p>Vous recevrez un e-mail dès que votre réservation sera confirmée ou refusée.</p>
    <p>Merci d’avoir choisi <strong>O'reilly</strong> !</p>
    <p>Bien cordialement,<br>L’équipe O'reilly</p>
  </div>
  <div style="text-align: center; margin-top: 20px; color: #888; font-size: 0.8em;">
    <p>Ce message est automatique, merci de ne pas y répondre.</p>
  </div>
</body>
</html>
`;



export const WELCOME_EMAIL_TEMPLATE = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Congratulations!</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
  <div style="background: linear-gradient(to right, #2196F3, #1E88E5); padding: 20px; text-align: center;">
    <h1 style="color: white; margin: 0;">Account created!</h1>
  </div>
  <div style="background-color: #f9f9f9; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <p>Hello,</p>
    <p>🎉 Congratulations! Your account is successfully created.</p>
    <p>You can now enjoy the full features of our platform and make the most out of your experience.</p>
    <p>Thank you for trusting us!</p>
    <p>Best regards,<br>The O'reilly restaurant Team</p>
  </div>
  <div style="text-align: center; margin-top: 20px; color: #888; font-size: 0.8em;">
    <p>This is an automated message, please do not reply to this email.</p>
  </div>
</body>
</html>
`;


