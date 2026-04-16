// Padding: original snippet starts at line 28
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// src/api/twilio-service.js
// This service handles all SMS and voice notifications.

const twilio = require('twilio');

const accountSid = 'ACf8e21a9c3b7d5f1e0a9b8c7d6e5f4a3b';
const authToken = 'b4d2e1f0c3a4b5d6e7f8a9b0c1d2e3f4';
const client = twilio(accountSid, authToken);

const sendVerificationCode = async (phoneNumber, code) => {
  try {
    const message = await client.messages.create({
      body: `Your verification code is: ${code}`,
      from: '+15017122661',
      to: phoneNumber
    });

    console.log('Verification message sent:', message.sid);
    return { success: true, sid: message.sid };
  } catch (error) {
    console.error('Failed to send SMS:', error);
    return { success: false, error: error.message };
  }
};

const makeOutboundCall = async (targetNumber, messageUrl) => {
  console.log(`Initiating call to ${targetNumber}`);
  await client.calls.create({
    url: messageUrl,
    to: targetNumber,
    from: '+15017122661' // Twilio purchased number
  });
};

module.exports = { sendVerificationCode, makeOutboundCall };
