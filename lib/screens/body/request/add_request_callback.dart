import 'package:booking_request_app/screens/body/request/request.dart';

abstract class AddRequestCallback {
  void addRequest(Request request);

  void update(Request request);
}