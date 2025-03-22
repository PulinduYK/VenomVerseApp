import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FirebaseAuth, FirebaseFirestore, FirebaseApp])
void main() {} // Required for mockito to work
