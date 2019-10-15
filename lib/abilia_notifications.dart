import 'dart:async';

import 'package:flutter/services.dart';

class AbiliaNotifications {
  static const MethodChannel _channel =
      const MethodChannel('abilia_notifications');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> setNotification() async {
    final apa = await _channel.invokeMethod('setNotification');
    await _channel.invokeMethod('show', <String, dynamic>{
      'id': 0,
      'title': "Titleee",
      'body': "Bodddyy",
    });
    print('What is apa: $apa');
  }

  static Future<void> initialize() async {
    await _channel.invokeMethod('initialize');
  }
}
