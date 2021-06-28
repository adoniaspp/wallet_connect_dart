import 'dart:convert';
import 'package:wallet_connect_dart/src/Models/ClientMeta.dart';

class WCSessionRequestResponseResult {
  final String peerId;
  final ClientMeta peerMeta;
  final bool approved;
  final int chainId;
  final int networkId;
  final List accounts;

  WCSessionRequestResponseResult({this.peerId, this.peerMeta, this.approved, this.chainId, this.accounts, this.networkId});

  WCSessionRequestResponseResult.fromJson(Map<String, dynamic> jsonData)
    :peerId = jsonData['peerId'],
    peerMeta = ClientMeta.fromJson(jsonData['peerMeta']),
    approved = jsonData['approved'],
    chainId = jsonData['chainId'],
    accounts = [jsonData['accounts']],
    networkId = jsonData['networkId'];
}