import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ProductContentEvent {
  String result;
  ProductContentEvent(this.result);
}

class LoginEvent {
  String result;
  LoginEvent(this.result);
}
