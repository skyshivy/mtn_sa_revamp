import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:encrypt/encrypt.dart';

class Decryptor {
  String encryptedKey = 'mofSSBh+ys/nwHn8EBmXgg==';
  String encryptedIV = '';

  String aesEnc(String text) {
    final key = encrypt.Key.fromBase64(encryptedKey);
    final iv = encrypt.IV.fromBase64(encryptedIV);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(text, iv: iv);

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print("encrypted text in base 64 is ======= \n$text");
    print("\nEncrypted value is \n${encrypted.base64}\n");
    print("\ndencrypted value is \n$decrypted\n");
    return encrypted.base64;
  }

  String decryptWithAES(String text) {
    final key = encrypt.Key.fromBase64(encryptedKey);
    final iv = encrypt.IV.fromBase64(encryptedIV);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
    print("Decrypted text in base 64 is  \n$decrypted");
    return decrypted;
  }
}
