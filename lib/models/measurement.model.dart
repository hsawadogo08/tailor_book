import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor_book/enums/status_work.enum.dart';
import 'package:tailor_book/models/customer.model.dart';

class Measurement {
  String? id;
  String? model;
  int? totalPrice;
  int? advancedPrice;
  String? photoModelUrl;
  XFile? photoModel;
  XFile? photoTissu;
  String? photoTissuUrl;
  Map<String, dynamic>? measures;
  DateTime? createdDate;
  DateTime? removedDate;
  bool? isClosed;
  String? customerId;
  Customer? customer;
  String? customerName;
  String? userUID;
  String? status;

  Measurement({
    this.id = "",
    this.model = "",
    this.totalPrice = 0,
    this.advancedPrice = 0,
    this.photoModelUrl = "",
    this.photoTissuUrl = "",
    this.measures = const {},
    this.customerId = "",
    this.isClosed = false,
    this.userUID = "",
    this.customerName = '',
    this.status = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "model": model,
      "totalPrice": totalPrice,
      "advancedPrice": advancedPrice,
      "photoModelUrl": photoModelUrl,
      "photoTissuUrl": photoTissuUrl,
      "measures": measures,
      "isClosed": isClosed,
      "createdDate": createdDate ?? DateTime.now(),
      "removedDate": removedDate ?? DateTime.now().add(const Duration(days: 5)),
      "customerId": customerId,
      "customerName":
          "${customer?.lastName} ${customer?.firstName} - ${customer?.phoneNumber}",
      "userUID": userUID,
      "status": StatusWork.PENDING.name,
    };
  }

  Measurement.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Timestamp docCreatedDate = data['createdDate'];
    Timestamp docRemovedDate = data['removedDate'];

    id = doc.id;
    model = data["model"];
    totalPrice = data["totalPrice"];
    advancedPrice = data["advancedPrice"];
    photoModelUrl = data["photoModelUrl"];
    photoTissuUrl = data["photoTissuUrl"];
    measures = data["measures"];
    isClosed = data["isClosed"];
    createdDate = DateTime.fromMillisecondsSinceEpoch(
        docCreatedDate.millisecondsSinceEpoch);
    removedDate = DateTime.fromMillisecondsSinceEpoch(
        docRemovedDate.millisecondsSinceEpoch);
    customerId = data["customerId"];
    customerName = data["customerName"];
    userUID = data["userUID"];
    status = data["status"] ?? StatusWork.PENDING.name;
  }
}
