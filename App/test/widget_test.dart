import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create a fake Firebase class
class MockFirebase extends Mock implements FirebaseApp {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock Firebase initialization
    registerFallbackValue(MockFirebase());
  });

  test('Firebase should not initialize during tests', () {
    expect(Firebase.apps.isEmpty, true); // Firebase should not be initialized
  });
}
