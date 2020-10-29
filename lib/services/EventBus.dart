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

class AddressEvent {
  String result;
  AddressEvent(this.result);
}

class AddressEditEvent {
  String result;
  AddressEditEvent(this.result);
}
