import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:hex/hex.dart';
import 'package:wallet_connect_dart/src/Models/WSMessage.dart';

class Crypto {
  AesCbc _algorithm;
  SecretKey _secretKey;
  String _secretKeyUrl;
  Hmac _hmac;

  Crypto(){
    _hmac = Hmac.sha256();
    _algorithm = AesCbc.with256bits(
      macAlgorithm: MacAlgorithm.empty,
    );
  }

  Future<void> initKey() async {
    _secretKey = await _algorithm.newSecretKey();

    await _secretKey.extractBytes().then((value) {
      _secretKeyUrl = HEX.encode(value);
    });
  }

  String get secretKey => _secretKeyUrl;

  Future<SecretBox> cypher(final data) async {
    return await _algorithm.encrypt(
      Utf8Encoder().convert(data),
      secretKey: _secretKey,
    );
  }

  Future<String> decipher(WSMessage WSResponse) async {
    final secretBoxData = SecretBox(HEX.decode(WSResponse.payload.data),
        nonce: HEX.decode(WSResponse.payload.iv), mac: Mac(const <int>[]));
    final clearText = await _algorithm
        .decrypt(secretBoxData, secretKey: _secretKey, aad: const <int>[]);
    return Utf8Decoder().convert(clearText);
  }

  Future<List<int>> sign(List<int> cipherText, List<int> nonce) async {
    final dataMac = cipherText + nonce;
    final _mac = await _hmac.calculateMac(
      dataMac,
      secretKey: _secretKey,
    );
    return _mac.bytes;
  }

  Future<bool> checkSign(WSMessage WSResponse) async {
    final dataMac =
        HEX.decode(WSResponse.payload.data) + HEX.decode(WSResponse.payload.iv);
    final secretBoxDataMac = SecretBox(dataMac,
        nonce: HEX.decode(WSResponse.payload.iv),
        mac: Mac(HEX.decode(WSResponse.payload.hmac)));
    await secretBoxDataMac
        .checkMac(
            macAlgorithm: _hmac, secretKey: _secretKey, aad: const <int>[])
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
}
