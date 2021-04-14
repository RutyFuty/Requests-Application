import 'package:flutter/material.dart';


/*TODO: 1) Выбор режима приложения (пользователь/ремонтник);
        2) Тема?? Светлая - Темная;
        3) Автозаполнение форм для пользователя;
        4) Управление аккаунтом? (смена пароля);
        5) Persistence - сохраняем настройки;
 */

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool _nightTheme = false;
  bool _autoFill = false;
  String _selectedFont;
  final List<String> _fontMode = [
    'Маленький',
    'Нормальный',
    'Крупный',
  ];
  String _selectedMode;
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
                  children: <Widget>[
                    Expanded(child: Text('Ночная тема', style: fieldStyle)),
                    Switch(
                      value: _nightTheme,
                      onChanged: (value) {
                        setState(() {
                          _nightTheme = value;
                        });
                      },
                      activeColor: Colors.lightGreen,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('Шрифт текста', style: fieldStyle)),
                    DropdownButton<String>(
                      value: _selectedFont,
                      onChanged: (value) {
                        setState(() {
                          _selectedFont = value;
                          print(_selectedFont);
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
                    Expanded(child: Text('Автозаполнение формы', style: fieldStyle)),
                    Switch(
                      value: _autoFill,
                      onChanged: (value) {
                        setState(() {
                          _autoFill = value;
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
                      Expanded(child: Text('Режим приложения', style: fieldStyle)),
                      DropdownButton<String>(
                        value: _selectedMode,
                        onChanged: (value) {
                          setState(() {
                            _selectedMode = value;
                            print(_selectedMode);
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
                      Expanded(child: Text('EMAIL IS HERE', textAlign: TextAlign.end)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Row(
                    children: [
                      Expanded(child: Text('Сменить Пароль', style: fieldStyle)),
                      Expanded(child: Text('************', textAlign: TextAlign.end)),
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
