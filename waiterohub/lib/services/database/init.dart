import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseHelper {
  DatabaseHelper() {
    firestore = Firestore.instance;
    storage = FirebaseStorage(storageBucket: 'gs://waitero.appspot.com');
  }

  static Firestore firestore;
  static FirebaseStorage storage;
}
