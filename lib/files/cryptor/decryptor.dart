import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:encrypt/encrypt.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class Decryptor {
  String encryptedKey = "d2AQuZZDfTIlZeXW";
  String encryptedIV = "912QWA56CFB3SA3F";
  String otpDecryptionKey = "112QWA56CFB3SA3G";
  String otpDecryptionIV = "e2AQuZZDfTIlZeXX";

  String aesEnc(String text) {
    final key = encrypt.Key.fromUtf8(encryptedKey);
    final iv = encrypt.IV.fromUtf8(encryptedIV);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    printCustom("Encrypted otp is ${encrypted.base64}");
    printCustom("dencrypted otp is $decrypted");
    return encrypted.base64;
  }

  String decryptWithAES(String text, {bool isOtpDecrypt = false}) {
    print("Trying to decrypt $text");
    final key =
        encrypt.Key.fromUtf8(isOtpDecrypt ? otpDecryptionKey : encryptedKey);
    final iv =
        encrypt.IV.fromUtf8(isOtpDecrypt ? otpDecryptionIV : encryptedIV);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));

    String decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
    if (isOtpDecrypt) {
      print("Decrypted otp text in base 64 is  \n$decrypted");
    } else {
      print("Decrypted text in base 64 is  \n$decrypted");
    }

    return decrypted;
  }
}
