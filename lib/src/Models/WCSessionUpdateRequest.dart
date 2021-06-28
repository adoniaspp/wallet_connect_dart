import 'WCSessionMessage.dart';
import 'WCSessionUpdateRequestParams.dart';

class WCSessionUpdateRequest extends WCSessionMessage{

  WCSessionUpdateRequestParams params;

  WCSessionUpdateRequest({this.params});

  WCSessionUpdateRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    params = WCSessionUpdateRequestParams.fromJson(json['params'][0]);
  }
}