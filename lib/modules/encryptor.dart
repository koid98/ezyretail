import 'package:encrypt/encrypt.dart';

Future<String> encryption(String plainText) async {
  //Key lenght must be 16
  final key = Key.fromUtf8("ASDFGHJKLASDFGHJ");
  final iv = IV.fromUtf8("ASDFGHJKLASDFGHJ");

  final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

String decryption(String plainText) {
  final key = Key.fromUtf8("ASDFGHJKLASDFGHJ");
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));
  final decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);

  return decrypted;
}

final key = Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
final iv = IV.fromUtf8('put16characters!'); //16 chars

//encrypt
Future<String> encryptMyData(String text) async {
  final e = Encrypter(AES(key, mode: AESMode.cbc));
  final encryptedData = e.encrypt(text, iv: iv);
  return encryptedData.base64;
}

//dycrypt
Future<String> decryptMyData(String text) async {
  final e = Encrypter(AES(key, mode: AESMode.cbc));
  final decryptedData = e.decrypt(Encrypted.fromBase64(text), iv: iv);
  return decryptedData;
}
