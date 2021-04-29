import 'package:firebase_database/firebase_database.dart';

class Request {
  //Основные поля заявки
  String _id;
  String _requestType;
  String _client;
  String _phone;
  String _email;
  String _organisation;
  String _contractNumber;
  String _address;
  String _equipment;
  String _comment;

  //Вспомогательные поля заявки
  String _status;
  String _date;
  String _requestNumber;

  Request(
      this._id,
      this._requestType,
      this._client,
      this._phone,
      this._email,
      this._organisation,
      this._contractNumber,
      this._address,
      this._equipment,
      this._comment,
      this._status,
      this._date,
      this._requestNumber);

  String get id => _id;

  String get requestType => _requestType;

  String get client => _client;

  String get phone => _phone;

  String get email => _email;

  String get organisation => _organisation;

  String get contractNumber => _contractNumber;

  String get address => _address;

  String get equipment => _equipment;

  String get comment => _comment;

  String get status => _status;

  String get date => _date;

  String get requestNumber => _requestNumber;

  Request.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _requestType = snapshot.value['requestType'];
    _client = snapshot.value['client'];
    _phone = snapshot.value['phone'];
    _email = snapshot.value['email'];
    _organisation = snapshot.value['organisation'];
    _contractNumber = snapshot.value['contractNumber'];
    _address = snapshot.value['address'];
    _equipment = snapshot.value['equipment'];
    _comment = snapshot.value['comment'];
    _status = snapshot.value['status'];
    _date = snapshot.value['date'];
    _requestNumber = snapshot.value['requestNumber'];
  }
}
