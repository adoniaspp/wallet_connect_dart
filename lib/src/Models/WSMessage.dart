import 'dart:convert';
import 'EncryptionPayload.dart';

class WSMessage {
  final String topic;
  final String type;
  final EncryptionPayload payload;

  WSMessage({this.topic, this.type, this.payload});

  WSMessage.fromJson(Map<String, dynamic> jsonData)
    :topic = jsonData['topic'],
    type = jsonData['type'],
    payload = EncryptionPayload.fromJson(json.decode(jsonData['payload']));
}