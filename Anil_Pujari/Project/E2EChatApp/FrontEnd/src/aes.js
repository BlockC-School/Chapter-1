var CryptoJS = require("crypto-js");

var secret_key = "uI2ooxtwHeI6q69PS98fx9SWVGbpQohO";

export const to_Encrypt = (text, key) => {
  const secret = key || secret_key;
  var encrypted = CryptoJS.AES.encrypt(text,secret);

  return encrypted.toString();
};
export const to_Decrypt = (cipher, username, key) => {
  const secret = key || secret_key;
  if (cipher.startsWith("Welcome")) {
    return cipher;
  }

  if (cipher.startsWith(username)) {
    return cipher;
  }

  const decrypted = CryptoJS.AES.decrypt( cipher,secret);
  const ecryptedText = decrypted.toString(CryptoJS.enc.Utf8);
  return ecryptedText;
  ;
};
