import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/services/customer.service.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

class MeasureService {
  static CollectionReference measures =
      FirebaseFirestore.instance.collection('measures');

  static Future<String> save(Measurement measurement) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      userUID = "MDL1Hd2dsSQxPEPTgouzogfTL8B2";
      // throw Exception("Le compte est introuvable !");
    }

    String customerId = await CustomerService.save(measurement.customer!);
    measurement.userUID = userUID;
    measurement.customerId = customerId;
    DocumentReference savedDoc = await measures.add(measurement.toMap());
    return savedDoc.id;
  }

  static Future<QuerySnapshot<Object?>> getAllMeasures({
    int? size,
    String status = '',
  }) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      userUID = "MDL1Hd2dsSQxPEPTgouzogfTL8B2";
      // throw Exception("Le compte est introuvable !");
    }
    return await measures
        .where("userUID", isEqualTo: userUID)
        .orderBy('createdDate', descending: true)
        .get();
  }
}
