class EncryptionPayload {
  final String data;
  final String hmac;
  final String iv;

  EncryptionPayload({this.data, this.hmac, this.iv});

  EncryptionPayload.fromJson(Map<String, dynamic> json)
    :data = json['data'],
    hmac = json['hmac'],
    iv = json['iv'];
}