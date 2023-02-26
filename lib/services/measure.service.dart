import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_book/models/measurement.model.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/services/customer.service.dart';
import 'package:tailor_book/services/photo.service.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

class MeasureService {
  static CollectionReference measures =
      FirebaseFirestore.instance.collection('measures');

  static Future<String> save(Measurement measurement) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);
    if (userUID == "") {
      throw Exception("Le compte est introuvable !");
    }

    if (measurement.photoModel != null) {
      try {
        String? photoModelURL =
            await PhotoService.savePhoto(measurement.photoModel!, "models");
        measurement.photoModelUrl = photoModelURL;
      } on Exception catch (_) {
        throw Exception(
          "Une erreur est survenue lors de l'enregistrement de la photo du model !",
        );
      }
    }

    if (measurement.photoTissu != null) {
      try {
        String? photoTissuUrl =
            await PhotoService.savePhoto(measurement.photoTissu!, "tissus");
        measurement.photoTissuUrl = photoTissuUrl;
      } on Exception catch (_) {
        throw Exception(
          "Une erreur est survenue lors de l'enregistrement de la photo du model !",
        );
      }
    }

    String customerId = await CustomerService.save(measurement.customer!);
    measurement.userUID = userUID;
    measurement.customerId = customerId;
    DocumentReference savedDoc = await measures.add(measurement.toMap());
    return savedDoc.id;
  }

  static Future<QuerySnapshot<Object?>> getAllMeasures({
    int? size = 10,
    String status = '',
  }) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      throw Exception("Le compte est introuvable !");
    }

    return status == ''
        ? await measures
            .where("userUID", isEqualTo: userUID)
            .where("deleted", isEqualTo: false)
            .orderBy('createdDate', descending: true)
            // .limit(1)
            .get()
        : await measures
            .where("userUID", isEqualTo: userUID)
            .where("deleted", isEqualTo: false)
            .where("status", isEqualTo: status)
            .orderBy('createdDate', descending: true)
            // .limit(1)
            .get();
  }

  static Future<void> updateStatus(String measureId, String status) async {
    return await measures.doc(measureId).update({'status': status});
  }

  static Future<void> delete(Measurement measurement) async {
    await CustomerService.updateCustomerPointFidelity(measurement.customerId!);
    return await measures.doc(measurement.id).update({'deleted': true});
  }

  static Future<void> doLinkToPersonnal(
      String measureId, Personnel personnel) async {
    return await measures.doc(measureId).update(
      {
        'couturierId': personnel.id,
        'couturierName':
            "${personnel.lastName} ${personnel.firstName} - ${personnel.phoneNumber}",
        'linkedDate': DateTime.now(),
      },
    );
  }
}
