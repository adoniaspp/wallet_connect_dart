import 'dart:async';
import 'dart:convert';
import 'package:wallet_connect_dart/src/Cryptography/Crypto.dart';
import 'package:wallet_connect_dart/src/Models/WCSessionMessage.dart';
import 'package:wallet_connect_dart/src/Models/WCSessionRequestResponse.dart';
import 'package:wallet_connect_dart/src/Models/WCSessionUpdateRequest.dart';
import 'package:wallet_connect_dart/src/Models/WSMessage.dart';
import 'package:wallet_connect_dart/src/WebSocketMessages/Topic.dart';

class ResponseHandler {

  Topic topics;
  Crypto _cryptography;
  static StreamController<Map<String, dynamic>> controllerResponse = StreamController<Map<String, dynamic>>();

  ResponseHandler(Crypto cryptoInstance, Topic topicsObject){
      _cryptography = cryptoInstance;
      topics = topicsObject;
  }
  
  responseHandler(dynamic message) async {
     //converter de json para objeto.
    final WSResponse = WSMessage.fromJson(json.decode(message));
    //Verifica a assinatura HMAC
    final checkSign = await _cryptography.checkSign(WSResponse).then((value) => value);

    //decriptar o payload data da message.
    final clearText = await _cryptography.decipher(WSResponse).then((value)=>value);
    
    /*Implementar aqui o controle central de recebimento de mensagens e rotear para cada tipo*/
    final wCSessionMessage = WCSessionMessage.fromJson(json.decode(clearText));

    print(WSResponse.topic);
    //topics.linkTopic = WSResponse.topic;
    controllerResponse.add(json.decode(clearText));
    
    /*switch (wCSessionMessage.method) {
      case 'wc_sessionUpdate':
        WCSessionUpdateRequest.fromJson(json.decode(clearText));
        //chama o método para tratar.
        print("update");
        break;
      default:
        WCSessionRequestResponse.fromJson(json.decode(clearText));
        //chama o método para tratar.
        controllerResponse.add(json.decode(clearText));
        print("request");
    }*/
  }
}
