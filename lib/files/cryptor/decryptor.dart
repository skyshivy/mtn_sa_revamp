import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:encrypt/encrypt.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class Decryptor {
  String encryptedKey = "d2AQuZZDfTIlZeXW"; //"mofSSBh+ys/nwHn8EBmXgg==";
  String encryptedIV = "912QWA56CFB3SA3F";

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

  String decryptWithAES(String text) {
    final key = encrypt.Key.fromUtf8(encryptedKey);
    final iv = encrypt.IV.fromUtf8(encryptedIV);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
    printCustom("Decrypted text in base 64 is  \n$decrypted");

    return decrypted;
  }
  // String encryptedKey = 'mofSSBh+ys/nwHn8EBmXgg==';
  // String encryptedIV = '';

  // String aesEnc(String text) {
  //   final key = encrypt.Key.fromBase64(encryptedKey);
  //   final iv = encrypt.IV.fromBase64(encryptedIV);

  //   final encrypter = encrypt.Encrypter(
  //       encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
  //   final encrypted = encrypter.encrypt(text, iv: iv);

  //   final decrypted = encrypter.decrypt(encrypted, iv: iv);
  //   printCustom("encrypted text in base 64 is ======= \n$text");
  //   printCustom("\nEncrypted value is \n${encrypted.base64}\n");
  //   printCustom("\ndencrypted value is \n$decrypted\n");
  //   return encrypted.base64;
  // }

  // String decryptWithAES(String text) {
  //   final key = encrypt.Key.fromBase64(encryptedKey);
  //   final iv = encrypt.IV.fromBase64(encryptedIV);
  //   final encrypter = encrypt.Encrypter(
  //       encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
  //   final decrypted =
  //       encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  //   printCustom("Decrypted text in base 64 is  \n$decrypted");
  //   return decrypted;
  // }
}
