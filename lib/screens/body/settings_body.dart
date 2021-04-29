import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool _autoFill = false;

  String _selectedFontSize;
  String _selectedMode;
  double _addFontSize = 0.0;
  final List<String> _fontMode = [
    'Маленький',
    'Нормальный',
    'Крупный',
  ];
  final List<String> _appMode = [
    'Клиент',
    'Сервис',
  ];

  //Поля для автозаполнения
  String _client;
  String _contract;
  String _organisation;
  String _address;
  String _phone;
  String _email;

  TextStyle headerStyle;
  TextStyle fieldStyle;
  TextStyle dataStyle;

  @override
  void initState() {
    super.initState();
    _loadAutoFill();
    _loadFont();
    _loadMode();
    _loadFields();
  }

  //Persistence - загрузка объектов (настроек);
  _loadAutoFill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _autoFill = (prefs.getBool('autoFill') ?? this._autoFill);
    });
  }

  _loadFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedFontSize = (prefs.getString('selectedFontSize'));
      _addFontSize = (prefs.getDouble('addFontSize'));
      if (_addFontSize == null) {
        prefs.setDouble('addFontSize', 0.0);
      }
    });
  }

  _loadMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMode = (prefs.getString('selectedMode'));
    });
  }

  _loadFields() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _client = (prefs.getString('fillClient'));
      _contract = (prefs.getString('fillContract'));
      _organisation = (prefs.getString('fillOrganisation'));
      _address = (prefs.getString('fillAddress'));
      _phone = (prefs.getString('fillPhone'));
      _email = (prefs.getString('fillEmail'));
    });
  }

  //Persistence - сохранение объектов (настроек);
  _saveAutoFill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('autoFill', _autoFill);
    });
  }

  _saveFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('selectedFontSize', _selectedFontSize);
      prefs.setDouble('addFontSize', _addFontSize);
    });
  }

  _saveMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('selectedMode', _selectedMode);
    });
  }

  _saveFields() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('fillClient', _client);
      prefs.setString('fillContract', _contract);
      prefs.setString('fillOrganisation', _organisation);
      prefs.setString('fillAddress', _address);
      prefs.setString('fillPhone', _phone);
      prefs.setString('fillEmail', _email);
    });
  }

  Widget _showAutoFields() {
    if (_autoFill) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ФИО',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _client = text;
                    _saveFields();
                  },
                  initialValue: _client,
                  keyboardType: TextInputType.name,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '№ контракта',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _contract = text;
                    _saveFields();
                  },
                  initialValue: _contract,
                  keyboardType: TextInputType.number,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Организация',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _organisation = text;
                    _saveFields();
                  },
                  initialValue: _organisation,
                  keyboardType: TextInputType.text,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Адрес',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _address = text;
                    _saveFields();
                  },
                  initialValue: _address,
                  keyboardType: TextInputType.streetAddress,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Эл. почта',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _email = text;
                    _saveFields();
                  },
                  initialValue: _email,
                  keyboardType: TextInputType.emailAddress,
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Телефон',
                    style: fieldStyle,
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (text) {
                    _phone = text;
                    _saveFields();
                  },
                  initialValue: _phone,
                  keyboardType: TextInputType.phone,
                )),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    headerStyle = TextStyle(
      fontSize: 18.0 + ((_addFontSize == null) ? 0.0 : _addFontSize),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
    fieldStyle = TextStyle(
      fontSize: 17.0 + ((_addFontSize == null) ? 0.0 : _addFontSize),
      fontWeight: FontWeight.normal,
      color: Color(0xFF808080),
    );
    dataStyle = TextStyle(
      fontSize: 17.0 + ((_addFontSize == null) ? 0.0 : _addFontSize),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: Column(
              children: <Widget>[
                Text('Общие', style: headerStyle),
                Row(
                  children: [
                    Expanded(child: Text('Шрифт текста', style: fieldStyle)),
                    DropdownButton<String>(
                      value: _selectedFontSize,
                      onChanged: (value) {
                        setState(() {
                          _selectedFontSize = value;
                          switch (_selectedFontSize) {
                            case 'Маленький':
                              _addFontSize = -3;
                              break;
                            case 'Нормальный':
                              _addFontSize = 0;
                              break;
                            case 'Крупный':
                              _addFontSize = 3;
                              break;
                          }
                          _saveFont();
                        });
                      },
                      items: _fontMode.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: Column(
              children: <Widget>[
                Text('Настройки автозаполнения', style: headerStyle),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text('Автозаполнение формы', style: fieldStyle)),
                    Switch(
                      value: _autoFill,
                      onChanged: (value) {
                        setState(() {
                          _autoFill = value;
                          _saveAutoFill();
                        });
                      },
                      activeColor: Colors.lightGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _showAutoFields(),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: Column(
              children: <Widget>[
                Text('Управление приложением', style: headerStyle),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('Режим приложения', style: fieldStyle)),
                      DropdownButton<String>(
                        value: _selectedMode,
                        onChanged: (value) {
                          setState(() {
                            _selectedMode = value;
                            _saveMode();
                          });
                        },
                        items: _appMode.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
