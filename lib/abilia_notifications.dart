import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AbiliaNotifications {
  static const MethodChannel _channel =
      const MethodChannel('abilia_notifications');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> setNotification(
      String title, String body, DateTime date) async {
    await _channel.invokeMethod('setNotification', [
      <String, dynamic>{
        'id': Uuid().v4(),
        'title': title,
        'body': body,
        'millisecondsSinceEpoch': date.millisecondsSinceEpoch,
      }
    ]);
  }

  static Future<void> initialize() async {
    await _channel.invokeMethod('initialize');
  }
}
