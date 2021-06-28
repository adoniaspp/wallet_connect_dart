import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:wallet_connect_dart/src/Cryptography/Crypto.dart';
import 'package:wallet_connect_dart/src/HandlersResponsesWC/ResponseHandler.dart';
import 'package:web_socket_channel/io.dart';
import 'package:hex/hex.dart';

import 'Topic.dart';

class WebSocketMessages
{
  //Juntar novamente as classes SendWebSocketMessages e WSConnection.
  //Separar somente os topics em uma classe de model.
  Uri _urlBridge;
  Topic topics;
  //String subscribeTopic;
  //String linkTopic;
  IOWebSocketChannel channel;
  Crypto _cryptography;
  final version = "1";
  List<int> _mac;

  WebSocketMessages(Crypto _cryptographyObject)
  {
      _urlBridge = Uri.parse('wss://bridge.walletconnect.org');
      /*final subscribeUuid = Uuid();
      subscribeTopic = subscribeUuid.v1();
      final linkUuid = Uuid();
      linkTopic = linkUuid.v1();*/
      topics = Topic();
      _cryptography = _cryptographyObject;

  }

  void openConnection() {
    channel = IOWebSocketChannel.connect(_urlBridge);
    channel.stream.listen(ResponseHandler(_cryptography, topics).responseHandler,onDone: (){
      print("Desconectado");
      sessionReconect();
    },
    onError: (exception){
      print("Desconectado");
      sessionReconect();
    });
    
  }

  Future<void> sessionReconect() async {
    //Abre o socket.
    openConnection();
    //Envia o sub.
    sendSub();

    print("Reconectado");
  }

    void displayURI() {
    print("wc:" +
        topics.linkTopic +
        "@" +
        version +
        "?bridge=" +
        _urlBridge.toString() +
        "&key=" +
        _cryptography.secretKey);
  }

  void sendSub() {
    print(topics.subscribeTopic);
    final sub = {
      'topic': topics.subscribeTopic,
      'type': 'sub',
      'silent': true,
      'payload': ''
    };
    final jsonText = jsonEncode(sub);
    channel.sink.add(jsonText);
  }


Future<void> sendPub(String method, Map<String, dynamic> params) async {
    //final random = Random();
    final session = {
      'id': 1,//random.nextInt(10),
      'jsonrpc': '2.0',
      'method': method,
      'params': 
        params.isEmpty ? [] : [params]
        /*{
          'peerId': _subscribeTopic,
          'peerMeta': _clientMeta.toJson(),
          'chainId': 1,
        }*/
    };
    final jsonSessionRequest = jsonEncode(session);
    //Criptografia dos dados
    final encrypted = await _cryptography.cypher(jsonSessionRequest);

    //Assinatura
    _mac = await _cryptography.sign(encrypted.cipherText, encrypted.nonce);

    final payload = {
      'data': HEX.encode(encrypted.cipherText),
      'hmac': HEX.encode(_mac),
      'iv': HEX.encode(encrypted.nonce)
    };

    final pub = {
      'topic': topics.linkTopic,
      'type': 'pub',
      'silent': false,
      'payload': jsonEncode(payload)
    };

    final jsonPub = jsonEncode(pub);
    print(jsonPub);
    channel.sink.add(jsonPub);
  }

}