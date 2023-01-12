import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailor_book/models/utilisateur.model.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createUser(Utilisateur utilisateur) async {
    try {
      return users.doc(utilisateur.userUID).set(
            utilisateur.toMap(),
          );
    } on Exception catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
