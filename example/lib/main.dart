import 'package:flutter/material.dart';
import 'dart:async';

import 'package:abilia_notifications/abilia_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> setNotification() async {
    print('Setting notification');
    await AbiliaNotifications.setNotification(
        "Title", "Body", DateTime.now().add(Duration(seconds: 10)));
    print('Notification is now set');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Larm om 10 sekunder'),
                onPressed: () {
                  setNotification().then(print).catchError(print);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
