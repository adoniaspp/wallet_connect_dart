class WCSessionMessage {
  final int id;
  final String jsonRpcVersion;
  final String method;

  WCSessionMessage({this.id, this.jsonRpcVersion, this.method});

  WCSessionMessage.fromJson(Map<String, dynamic> json)
    :id = json['id'],
    jsonRpcVersion = json['jsonRpcVersion'],
    method = json['method'];
}