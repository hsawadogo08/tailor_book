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
  String? couturierId;
  String? couturierName;
  DateTime? linkedDate;
  bool? deleted;

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
    this.couturierId = '',
    this.couturierName = '',
    this.deleted = false,
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
      "couturierId": couturierId,
      "couturierName": couturierName,
      "linkedDate": DateTime.now(),
      "deleted": deleted,
    };
  }

  Measurement.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Timestamp docCreatedDate = data['createdDate'];
    Timestamp docRemovedDate = data['removedDate'];
    Timestamp doclinkedDate =
        data['linkedDate'] ?? Timestamp.fromDate(DateTime.now());

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
    couturierId = data["couturierId"];
    couturierName = data["couturierName"];
    linkedDate = DateTime.fromMillisecondsSinceEpoch(
        doclinkedDate.millisecondsSinceEpoch);
    deleted = data["deleted"] ?? false;
  }
}
