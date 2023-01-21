import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? id;
  String? code;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? userUID;
  int? pointFidelite;
  DateTime? createdDate;

  Customer({
    this.id = '',
    this.code = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.userUID = "",
    this.pointFidelite = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "lastName": lastName,
      "firstName": firstName,
      "phoneNumber": phoneNumber,
      "userUID": userUID,
      "pointFidelite": pointFidelite,
      "createdDate": DateTime.now(),
    };
  }

  Customer.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    id = doc.id;
    code = data["code"];
    lastName = data["lastName"];
    firstName = data["firstName"];
    phoneNumber = data["phoneNumber"];
    userUID = data["userUID"];
    pointFidelite = data["pointFidelite"] ?? 1;
    createdDate = data["createdDate"] ?? DateTime.now();
  }
}
