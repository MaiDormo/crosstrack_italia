import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseAuth auth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseStorage storage(Ref ref) {
  return FirebaseStorage.instance;
}
