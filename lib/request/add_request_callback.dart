import 'package:booking_request_app/request/request.dart';

abstract class AddRequestCallback {
  void addRequest(Request request);

  void update(Request request);
}
