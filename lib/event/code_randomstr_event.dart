import 'package:event_bus/event_bus.dart';

EventBus codeRandomstrEvent = EventBus();

class CodeRandomstrEvent {
  String randomStr;

  CodeRandomstrEvent(this.randomStr);
}
