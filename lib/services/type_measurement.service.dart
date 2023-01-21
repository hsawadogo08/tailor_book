import 'package:cloud_firestore/cloud_firestore.dart';

class TypeMeasurementService {
  static CollectionReference typeMeasurement =
      FirebaseFirestore.instance.collection('TypeMeasurement');

  static Future<QuerySnapshot<Object?>> getAllTypeMeasurement() async {
    return await typeMeasurement.get();
  }

  static Future<Map<String, dynamic>> getTypeMeasurementByDocId(
      String docId) async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection("TypeMeasurement")
        .doc(docId)
        .get();
    return document.data() as Map<String, dynamic>;
  }
}
