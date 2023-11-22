import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:pointycastle/export.dart';

class Cryptom {
  String publickey =
      'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6gB+nXg9M+KC8MYYOu/NRLmFg85LRrfRszyI/vZ/k8dANG9euxOB79FZ2f302hU+3joQZoJ3Sxq/GbIIFf/3y4f9DuKI53y1qR2qD4xIskfa9rPVqvBtAu2KSNRd8V4J8RKI2gT2YEA+A3Z0mQq4GBRS8iYmGLqRQyPfNUSankylBrTpOIVFBZORdZehjJMmwl98UMuVnJfIhuX6WWy9JJoc5WylPhOiHpjxWlndq1lErI7Tv2N93fD7nxt+siZryfazn3EAgBaTKTV/U5xIepzDN6ZYJ4qnC93u6erdb1X4m1zU6RGapwzCOPOORTyzw/uWJ8twcODNt0cqVp+sYQIDAQAB';

  String encrypt(String plaintext, String publicKey) {
    printCustom('\nencrypted password is above=^^^^^^^^==> \n');
    var pem =
        '-----BEGIN RSA PUBLIC KEY-----\n$publickey\n-----END RSA PUBLIC KEY-----';

    var public = CryptoUtils.rsaPublicKeyFromPem(pem);

    var cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));
    Uint8List output =
        cipher.process(Uint8List.fromList(utf8.encode(plaintext)));
    var base64EncodedText = base64Encode(output);
    printCustom(
        '\nencrypted password is below=VVVVVVV==> \n$base64EncodedText\n');
    printCustom('\nencrypted password is above=^^^^^^^^==> \n');
    return base64EncodedText;
  }

  String text(String text) {
    return encrypt(text, publickey);
  }
}
