import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'request.dart';

//CRUD-методы для взаимодействия с базой данных
class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _requestRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  DatabaseReference get counterRef => _counterRef;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');

    // Demonstrates configuring the database directly
    _requestRef = database.reference().child('request');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getRequest() {
    return _requestRef;
  }

  addRequest(Request request) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _requestRef.push().set(<String, String>{
        "requestType": "" + request.requestType,
        "client": "" + request.client,
        "phone": "" + request.phone,
        "email": "" + request.email,
        "organisation": "" + request.organisation,
        "contractNumber": "" + request.contractNumber,
        "address": "" + request.address,
        "equipment": "" + request.equipment,
        "comment": "" + request.comment,
        "status": "" + request.status,
        "date": "" + request.date,
        "requestNumber": "" + request.requestNumber,
      }).then((_) {
        print('Transaction  committed. Total requests: $_counter');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteRequest(Request request) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) - 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _requestRef.child(request.id).remove().then((_) {
        print('Transaction  committed. Total requests: $_counter');
      });
    }
  }

  void updateRequest(Request request) async {
    await _requestRef.child(request.id).update({
      "requestType": "" + request.requestType,
      "client": "" + request.client,
      "phone": "" + request.phone,
      "email": "" + request.email,
      "organisation": "" + request.organisation,
      "contractNumber": "" + request.contractNumber,
      "address": "" + request.address,
      "equipment": "" + request.equipment,
      "comment": "" + request.comment,
      "status": "" + request.status,
      "date": "" + request.date,
      "requestNumber": "" + request.requestNumber,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
