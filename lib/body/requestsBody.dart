import 'package:booking_request_app/body/request/firebase_database_util.dart';
import 'package:booking_request_app/body/request/request.dart';
import 'package:booking_request_app/body/requestReview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'addAndEditRequest.dart';

class RequestsBody extends StatefulWidget {
  @override
  _RequestsBodyState createState() => _RequestsBodyState();
}

class _RequestsBodyState extends State<RequestsBody>
    implements AddRequestCallback {
  TextStyle style = TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal);

  bool _anchorToBottom = false;

  FirebaseDatabaseUtil databaseUtil;
  int _counter;

  @override
  Widget build(BuildContext context) {
    counterListener();
    return initBody();
  }

  Future counterListener() async {
    _counter = databaseUtil.getCounter();
    await new Future.delayed(const Duration(seconds: 3));
    setState(() {
    });
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  initBody() {
    return Scaffold(
      body: (_counter != 0)
          ? new FirebaseAnimatedList(
              defaultChild: Container(
                child: Center(child: Text('Загрузка...')),
              ),
              key: new ValueKey<bool>(_anchorToBottom),
              query: databaseUtil.getRequest(),
              reverse: _anchorToBottom,
              sort: _anchorToBottom
                  ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                  : null,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new SizeTransition(
                  sizeFactor: animation,
                  child: showRequest(snapshot),
                );
              },
            )
          : Container(
              child: Center(child: Text('Заявки отсутствуют')),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  new AddEditRequest(context, this, false, null),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void addRequest(Request request) {
    setState(() {
      databaseUtil.addRequest(request);
    });
  }

  @override
  void update(Request request) {
    setState(() {
      databaseUtil.updateRequest(request);
    });
  }

  Widget showRequest(DataSnapshot res) {
    Request request = Request.fromSnapshot(res);
    Color requestStatusColor = RequestStatusColor(request.status).getColor();
    TextStyle fieldStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFF808080),
    );
    TextStyle dataStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    var item = new Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RequestReview(request, databaseUtil, requestStatusColor)),
          );
        },
        child: new Container(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: new Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        '№ ' + request.requestNumber,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Тип требуемых работ',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          request.requestType,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Статус',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: requestStatusColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: new Text(
                                request.status,
                                style: dataStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Представитель',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          request.client,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Организация',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          request.organisation,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 20.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Дата формирования заявки',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          request.date,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return item;
  }
}

class RequestStatusColor {
  String status;
  Map<String, Color> statusColor = {
    'открыта': Color(0xFFFF8C00),
    'в работе': Color(0xFFAFEEEE),
    'отложена': Color(0xFFD3D3D3),
    'завершена': Color(0xFF7CFC00),
    'отменена': Color(0xFFFF6347)
  };

  RequestStatusColor(this.status);

  Color getColor() {
    Color _color = Color(0xFFC0C0C0);
    statusColor.forEach((key, value) {
      if (status == key) {
        _color = value;
      }
    });
    return _color;
  }
}
