import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFirebase {
  static Future<void> setup() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Setup method channel mocks
    const MethodChannel methodChannel =
        MethodChannel('plugins.flutter.io/firebase_core');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      methodChannel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'Firebase#initializeCore':
            return [
              {
                'name': '[DEFAULT]',
                'options': {
                  'apiKey': 'test-api-key',
                  'appId': 'test-app-id',
                  'messagingSenderId': 'test-sender-id',
                  'projectId': 'test-project-id',
                },
                'pluginConstants': {},
              }
            ];
          case 'Firebase#initializeApp':
            return {
              'name': methodCall.arguments['appName'],
              'options': methodCall.arguments['options'],
              'pluginConstants': {},
            };
          default:
            return null;
        }
      },
    );

    // Mock auth channel
    const MethodChannel authChannel =
        MethodChannel('plugins.flutter.io/firebase_auth');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      authChannel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'Auth#authStateChanges':
          case 'Auth#idTokenChanges':
          case 'Auth#userChanges':
            return null;
          case 'Auth#currentUser':
            return null;
          default:
            return null;
        }
      },
    );
  }
}
