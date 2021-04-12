import 'package:booking_request_app/body/request/firebase_database_util.dart';
import 'package:booking_request_app/body/request/request.dart';
import 'package:flutter/material.dart';

import 'addAndEditRequest.dart';

class RequestReview extends StatefulWidget {
  final Request _request;
  final FirebaseDatabaseUtil _databaseUtil;
  final Color _requestStatusColor;

  RequestReview(this._request, this._databaseUtil, this._requestStatusColor);

  @override
  _RequestReviewState createState() => _RequestReviewState();
}

class _RequestReviewState extends State<RequestReview>
    implements AddRequestCallback {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заявка № ' + widget._request.requestNumber),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        widget._request.requestType,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Клиент',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.organisation,
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
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Контракт №',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.contractNumber,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Контактное лицо',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.client,
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
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Адресс проведения работ',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.address,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Контактный телефон',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.phone,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Эл. почта',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.email,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                              color: widget._requestStatusColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: new Text(
                                widget._request.status,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                          widget._request.date,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Наименование оборудования, модель',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.equipment,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Описание неисправности, требуемые работы',
                          style: fieldStyle,
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          widget._request.comment,
                          style: dataStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => new AddEditRequest(
                                    context, this, true, widget._request),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30.0,
                                  color: const Color(0xFF167F67),
                                ),
                              ),
                              Text(
                                'Редактировать',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () => deleteRequest(widget._request),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.delete_forever,
                                    size: 30.0, color: const Color(0xFF167F67)),
                              ),
                              Text(
                                'Удалить',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
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
  }

  @override
  void addRequest(Request request) {
    setState(() {
      widget._databaseUtil.addRequest(request);
    });
  }

  @override
  void update(Request request) {
    setState(() {
      widget._databaseUtil.updateRequest(request);
    });
  }

  void deleteRequest(Request request) {
    setState(() {
      widget._databaseUtil.deleteRequest(request);
    });
    Navigator.pop(context);
  }
}
