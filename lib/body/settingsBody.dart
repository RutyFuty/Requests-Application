import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*TODO: 1) Выбор режима приложения (пользователь/ремонтник);
        2) Автозаполнение форм для пользователя;
        3) Управление аккаунтом? (смена пароля);
        4) Persistence - сохраняем настройки;
 */

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool _autoFill = false;

  // Request _request;
  String _selectedFontSize;
  String _selectedMode;
  final List<String> _fontMode = [
    'Маленький',
    'Нормальный',
    'Крупный',
  ];
  final List<String> _appMode = [
    'Клиент',
    'Сервис',
  ];

  TextStyle headerStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  TextStyle fieldStyle = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.normal,
    color: Color(0xFF808080),
  );
  TextStyle dataStyle = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    _loadAutoFill();
    _loadFont();
    _loadMode();
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
    });
  }

  _loadMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMode = (prefs.getString('selectedMode'));
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
    });
  }

  _saveMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('selectedMode', _selectedMode);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: Column(
              children: <Widget>[
                Text('Управление аккаунтом', style: headerStyle),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Row(
                    children: [
                      Expanded(child: Text('Сменить Email', style: fieldStyle)),
                      Expanded(
                          child:
                              Text('EMAIL IS HERE', textAlign: TextAlign.end)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('Сменить Пароль', style: fieldStyle)),
                      Expanded(
                          child:
                              Text('************', textAlign: TextAlign.end)),
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
