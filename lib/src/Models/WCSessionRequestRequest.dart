import 'WCSessionMessage.dart';
import 'WCSessionRequestRequestParams.dart';

class WCSessionRequestRequest extends WCSessionMessage {
  
  WCSessionRequestRequestParams params;

  WCSessionRequestRequest({this.params});

  WCSessionRequestRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    params = WCSessionRequestRequestParams.fromJson(json['params']);
  }
}