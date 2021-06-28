import 'package:uuid/uuid.dart';

class Topic
{
  String subscribeTopic;
  String linkTopic;

  Topic(){
      final subscribeUuid = Uuid();
      subscribeTopic = subscribeUuid.v1();
      final linkUuid = Uuid();
      linkTopic = linkUuid.v1();
  }
}