import 'package:booking_request_app/body/requestsBody.dart';
import 'package:booking_request_app/body/settingsBody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Текущая нижняя вкладка
  var _currentPage = 0;

  //Лист нижних вкладок
  List<dynamic> _bodyList = [RequestsBody(), SettingsBody()];

  void onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _initBody() {
    return _bodyList.elementAt(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    var _email = FirebaseAuth.instance.currentUser.email;
    var _name = _email.substring(0, _email.indexOf('@'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Привет, $_name'),
        actions: <Widget>[
          TextButton(
            child: Text('Выход',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _signOut,
          )
        ],
      ),
      body: _initBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Мои заявки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            onItemTapped(index);
          });
        },
      ),
    );
  }
}
