import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

/*
  ! In this file we initialize the database and the storage adress for future use.
  ? U ovoj datoteci pripremimo databazu i storage bucket za buduce koristenje.
*/

class DatabaseHelper {
  DatabaseHelper() {
    firestore = Firestore.instance;
    storage = FirebaseStorage(storageBucket: 'gs://waitero.appspot.com');
  }

  static Firestore firestore;
  static FirebaseStorage storage;
}
