import 'dart:convert';
import 'package:wallet_connect_dart/src/Models/ClientMeta.dart';

class WCSessionRequestRequestParams{
  final int peerId;
  final ClientMeta peerMeta;
  final int chainId;

  WCSessionRequestRequestParams({this.peerId, this.peerMeta, this.chainId});

  WCSessionRequestRequestParams.fromJson(Map<String, dynamic> jsonData)
    :peerId = jsonData['peerId'],
    peerMeta = ClientMeta.fromJson(json.decode(jsonData['peerMeta'])),
    chainId = jsonData['chainId'];

}