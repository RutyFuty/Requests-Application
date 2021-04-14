import 'dart:math';

import 'package:booking_request_app/body/request/request.dart';
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
  Request request;
  String _selectedMode;
  bool _isValid;

  final teRequestType = TextEditingController();
  final List<String> requestTypes = [
    'Плановое обслуживание',
    'Ремонт',
    'Обеспечение',
    'Создание нового рабочего места',
    'Утилизация оборудования',
    'Другое',
  ];
  final List<String> requestStatuses = [
    'открыта',
    'в работе',
    'отложена',
    'завершена',
    'отменена',
  ];
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

  //Генерируем номер заявки
  int numRequestNumber = new Random().nextInt(99999) + 1;
  String newRequestStatus = 'открыта';

  _loadMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMode = (prefs.getString('selectedMode'));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMode();
  }

  String _getDate() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    return '$day' + '.$month' + '.$year';
  }

  @override
  Widget build(BuildContext context) {
    if (widget._request != null) {
      this.request = widget._request;
      teRequestType.text = request.requestType;
      teClient.text = request.client;
      tePhone.text = request.phone;
      teEmail.text = request.email;
      teOrganisation.text = request.organisation;
      teContractNumber.text = request.contractNumber;
      teAddress.text = request.address;
      teEquipment.text = request.equipment;
      teComment.text = request.comment;
      teStatus.text = request.status;
      teDate.text = request.date;
      numRequestNumber = int.parse(request.requestNumber);
    }

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
              getTextField("Адресс проведения работ", teAddress,
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
        isEdit ? request.id : '',
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
    if (localRequest.requestType == '' ||
        localRequest.client == '' ||
        localRequest.phone == '' ||
        localRequest.email == '' ||
        localRequest.organisation == '' ||
        localRequest.contractNumber == '' ||
        localRequest.address == '' ||
        localRequest.equipment == '' ||
        localRequest.comment == '' ||
        localRequest.date == '') {
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

abstract class AddRequestCallback {
  void addRequest(Request request);

  void update(Request request);
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
        hint: Text(widget.inputBoxName),
        value: _initValue(),
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
            ),
          );
        }).toList(),
      ),
    );
  }

  _initValue() {
    var defaultValue = widget.ddRequestType.text;
    if (selectedType == null && defaultValue != '') {
      selectedType = defaultValue;
    }
    return selectedType;
  }
}
