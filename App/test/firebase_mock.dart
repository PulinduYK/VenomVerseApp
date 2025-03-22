import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFirebase {
  static Future<void> setupFirebaseMocks() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock the Firebase Core method channel
    const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
          (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'Firebase#initializeCore':
            return [
              {
                'name': '[DEFAULT]',
                'options': {
                  'apiKey': 'mock-api-key',
                  'appId': 'mock-app-id',
                  'messagingSenderId': 'mock-sender-id',
                  'projectId': 'mock-project-id',
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

    // Mock the Firebase Auth method channel
    const MethodChannel authChannel = MethodChannel('plugins.flutter.io/firebase_auth');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
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