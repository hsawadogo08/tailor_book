import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tailor_book/models/utilisateur.model.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<UserCredential> phoneAuthenticate(
      String phoneNumber, String password) async {
    return await auth.signInAnonymously();
  }

  static Future<UserCredential> signInAnonymously() async {
    return await auth.signInAnonymously();
  }

  static Future<Utilisateur?> onSignin(
      String phoneNumber, String password) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      userUID = "MDL1Hd2dsSQxPEPTgouzogfTL8B2";
      // throw Exception("Le compte est introuvable !");
    }
    await auth.signInAnonymously();
    DocumentSnapshot doc = await users.doc(userUID).get();

    Utilisateur utilisateur = Utilisateur.fromDocumentSnapshot(doc);

    if (utilisateur.phoneNumber != phoneNumber) {
      throw Exception("Les identifiants sont érronés !");
    } else if (utilisateur.password != password) {
      throw Exception("Les identifiants sont érronés !");
    }
    await SharedPrefConfig.saveBoolData(SharePrefKeys.IS_REGISTERED, true);
    await SharedPrefConfig.saveStringData(
        SharePrefKeys.USER_INFOS, utilisateur.toMap().toString());
    return utilisateur;
  }

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

  static Future<bool> getRegistedStatus() async {
    return await SharedPrefConfig.getBoolData(SharePrefKeys.IS_REGISTERED);
  }

  static Future<Utilisateur> getCurrentUserInfos() async {
    String currentUser =
        await SharedPrefConfig.getStringData(SharePrefKeys.USER_INFOS);
    Map<String, dynamic> map = jsonStringToMap(currentUser);
    return Utilisateur.fromMap(map);
  }

  static Map<String, dynamic> jsonStringToMap(String data) {
    List<String> str = data.replaceAll("{", "").replaceAll("}", "").split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(": ");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }
}
