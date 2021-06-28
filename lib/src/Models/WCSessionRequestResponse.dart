import 'WCSessionMessage.dart';
import 'WCSessionRequestResponseResult.dart';

class WCSessionRequestResponse extends WCSessionMessage{
  WCSessionRequestResponseResult result;

  WCSessionRequestResponse({this.result});

  WCSessionRequestResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    result = WCSessionRequestResponseResult.fromJson(json['result']);
  }
}