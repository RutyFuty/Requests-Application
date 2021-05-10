import 'dart:math';

import 'package:booking_request_app/request/add_request_callback.dart';
import 'package:booking_request_app/request/request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEditRequest extends StatefulWidget {
  final bool _isEdit;
  final AddRequestCallback _myAddPageState;
  final Request _request;

  AddEditRequest(
      BuildContext context, this._myAddPageState, this._isEdit, this._request);

  @override
  _AddEditRequestState createState() => _AddEditRequestState();
}

class _AddEditRequestState extends State<AddEditRequest> {
  Request _request;
  String _selectedMode;
  bool _isValid;
  bool _autoFill = false;

  //Типы заявок
  final List<String> requestTypes = [
    'Плановое обслуживание',
    'Ремонт',
    'Обеспечение',
    'Создание нового рабочего места',
    'Утилизация оборудования',
    'Другое',
  ];

  //Статусы заявок
  final String newRequestStatus = 'открыта';
  final List<String> requestStatuses = [
    'открыта',
    'в работе',
    'отложена',
    'завершена',
    'отменена',
  ];

  String _client;
  String _contract;
  String _organisation;
  String _address;
  String _phone;
  String _email;

  //Контроллеры текстовых полей
  final teRequestType = TextEditingController();
  final teClient = TextEditingController();
  final tePhone = TextEditingController();
  final teEmail = TextEditingController();
  final teOrganisation = TextEditingController();
  final teContractNumber = TextEditingController();
  final teAddress = TextEditingController();
  final teEquipment = TextEditingController();
  final teComment = TextEditingController();
  final teStatus = TextEditingController();
  final teDate = TextEditingController();

  //Генерируем номер заявки (от 1 до 99999)
  int numRequestNumber = new Random().nextInt(99999) + 1;

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMode = (prefs.getString('selectedMode'));
      _autoFill = (prefs.getBool('autoFill'));
      if (_autoFill == null) {
        prefs.setBool('autoFill', false);
      }

      _client = (prefs.getString('fillClient'));
      _contract = (prefs.getString('fillContract'));
      _organisation = (prefs.getString('fillOrganisation'));
      _address = (prefs.getString('fillAddress'));
      _phone = (prefs.getString('fillPhone'));
      _email = (prefs.getString('fillEmail'));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  String _getDate() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    return '$day' + '.$month' + '.$year';
  }

  void _checkRequest() {
    if (widget._request != null) {
      this._request = widget._request;
      teRequestType.text = _request.requestType;
      teClient.text = _request.client;
      tePhone.text = _request.phone;
      teEmail.text = _request.email;
      teOrganisation.text = _request.organisation;
      teContractNumber.text = _request.contractNumber;
      teAddress.text = _request.address;
      teEquipment.text = _request.equipment;
      teComment.text = _request.comment;
      teStatus.text = _request.status;
      teDate.text = _request.date;
      numRequestNumber = int.parse(_request.requestNumber);
    }
  }

  void _checkAutoFields() {
    if (_autoFill == null) {
      _autoFill = false;
    }
    if (_autoFill && widget._request == null) {
      if (_client.isNotEmpty) teClient.text = _client;
      if (_contract.isNotEmpty) teContractNumber.text = _contract;
      if (_organisation.isNotEmpty) teOrganisation.text = _organisation;
      if (_address.isNotEmpty) teAddress.text = _address;
      if (_phone.isNotEmpty) tePhone.text = _phone;
      if (_email.isNotEmpty) teEmail.text = _email;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkRequest();
    _checkAutoFields();

    return Scaffold(
      appBar: AppBar(
          title: new Text(
              widget._isEdit ? 'Редактирование заявки' : 'Создать заявку')),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: new SingleChildScrollView(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropDownWidget("Тип заявки", requestTypes, teRequestType),
              getTextField(
                  "Контактное лицо, ФИО", teClient, TextInputType.name),
              getTextField("Телефон", tePhone, TextInputType.phone),
              getTextField("Email", teEmail, TextInputType.emailAddress),
              getTextField("Организация", teOrganisation, TextInputType.text),
              getTextField(
                  "Контракт №", teContractNumber, TextInputType.number),
              getTextField("Адрес проведения работ", teAddress,
                  TextInputType.streetAddress),
              getTextField("Наименование оборудования/модель", teEquipment,
                  TextInputType.text),
              getTextField(
                  "Описание неисправности", teComment, TextInputType.multiline),
              (_selectedMode == 'Сервис')
                  ? DropDownWidget("Статус", requestStatuses, teStatus)
                  : Container(),
              (_selectedMode == 'Сервис')
                  ? getTextField("Дата", teDate, TextInputType.datetime)
                  : Container(),
              new GestureDetector(
                onTap: () =>
                    onTap(widget._isEdit, widget._myAddPageState, context),
                child: new Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: getAppBorderButton(
                      widget._isEdit ? "Готово" : "Добавить",
                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextField(String inputBoxName,
      TextEditingController inputBoxController, TextInputType textInputType) {
    var field = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: textInputType,
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
        validator: (value) =>
            value.isEmpty ? 'Поле не может быть пустым' : null,
      ),
    );
    return field;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Request getData(bool isEdit) {
    return new Request(
        isEdit ? _request.id : '',
        teRequestType.text,
        teClient.text,
        tePhone.text,
        teEmail.text,
        teOrganisation.text,
        teContractNumber.text,
        teAddress.text,
        teEquipment.text,
        teComment.text,
        (_selectedMode == 'Сервис') ? teStatus.text : newRequestStatus,
        (_selectedMode == 'Сервис') ? teDate.text : _getDate(),
        numRequestNumber.toString());
  }

  errorDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Не все поля заполнены'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onTap(
      bool isEdit, AddRequestCallback _myHomePageState, BuildContext context) {
    Request localRequest = getData(isEdit);
    //Проверка заявки на пустые поля
    if (localRequest.requestType.isEmpty ||
        localRequest.client.isEmpty ||
        localRequest.phone.isEmpty ||
        localRequest.email.isEmpty ||
        localRequest.organisation.isEmpty ||
        localRequest.contractNumber.isEmpty ||
        localRequest.address.isEmpty ||
        localRequest.equipment.isEmpty ||
        localRequest.comment.isEmpty ||
        localRequest.date.isEmpty) {
      _isValid = false;
    } else {
      _isValid = true;
    }

    if (_isValid) {
      if (isEdit) {
        _myHomePageState.update(localRequest);
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        _myHomePageState.addRequest(localRequest);
        Navigator.of(context).pop();
      }
    } else {
      errorDialog();
    }
  }
}

class DropDownWidget extends StatefulWidget {
  final String inputBoxName;
  final List<String> requestTypes;
  final TextEditingController ddRequestType;

  DropDownWidget(this.inputBoxName, this.requestTypes, this.ddRequestType);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        hint: Text(
          widget.inputBoxName,
          style: new TextStyle(
            color: const Color(0xFF28324E),
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
        value: (selectedType == null && widget.ddRequestType.text.isNotEmpty)
            ? selectedType = widget.ddRequestType.text
            : selectedType,
        onChanged: (value) {
          setState(() {
            selectedType = value;
            widget.ddRequestType.text = selectedType;
          });
        },
        items: widget.requestTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: new TextStyle(
                color: const Color(0xFF28324E),
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
