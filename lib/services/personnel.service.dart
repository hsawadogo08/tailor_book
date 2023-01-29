import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

class PersonnelService {
  static CollectionReference personnels =
      FirebaseFirestore.instance.collection('personnels');

  // ignore: slash_for_doc_comments
  /**
  // *   Save Customer
  // [personnel] is the object of Customer to save
  */
  static Future<String> save(Personnel personnel) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);
    if (userUID == "") {
      throw Exception("Le compte est introuvable !");
    }
    personnel.userUID = userUID;

    log("save Personnel ==> ${personnel.id}");

    if (personnel.id != "") {
      await personnels.doc(personnel.id).update({
        'lastName': personnel.lastName,
        'firstName': personnel.firstName,
        'phoneNumber': personnel.phoneNumber,
      });
      return personnel.id!;
    }

    DocumentReference savedDoc = await personnels.add(personnel.toMap());
    return savedDoc.id;
  }

  static Future<QuerySnapshot<Object?>> getAll() async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);
    log(userUID);

    if (userUID == "") {
      throw Exception("Le compte est introuvable !");
    }
    return await personnels
        .where("userUID", isEqualTo: userUID)
        .orderBy('createdDate', descending: true)
        .get();
  }
}
