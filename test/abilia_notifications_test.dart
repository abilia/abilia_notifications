import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:abilia_notifications/abilia_notifications.dart';

void main() {
  const MethodChannel channel = MethodChannel('abilia_notifications');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AbiliaNotifications.platformVersion, '42');
  });
}
