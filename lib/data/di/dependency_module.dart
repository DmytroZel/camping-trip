import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

@module
abstract class DependencyModule {
  @lazySingleton
  FirebaseAuth auth() => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore firestore() => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseStorage storage() => FirebaseStorage.instance;

  @preResolve
  Future<StreamingSharedPreferences> sharedPreferences() =>
      StreamingSharedPreferences.instance;
}
