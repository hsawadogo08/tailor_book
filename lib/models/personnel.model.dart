import 'package:cloud_firestore/cloud_firestore.dart';

class Personnel {
  String? id;
  String? code;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? userUID;
  int? pendingNumber;
  int? progressNumber;
  int? closedNumber;
  DateTime? createdDate;

  Personnel({
    this.id = '',
    this.code = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.pendingNumber = 0,
    this.progressNumber = 0,
    this.closedNumber = 0,
    this.userUID = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "lastName": lastName,
      "firstName": firstName,
      "phoneNumber": phoneNumber,
      "pendingNumber": pendingNumber,
      "progressNumber": progressNumber,
      "closedNumber": closedNumber,
      "userUID": userUID,
      "createdDate": DateTime.now(),
    };
  }

  Personnel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    Timestamp docCreatedDate = data['createdDate'] ?? Timestamp.now();
    id = doc.id;
    code = data["code"];
    lastName = data["lastName"];
    firstName = data["firstName"];
    phoneNumber = data["phoneNumber"];
    userUID = data["userUID"];
    createdDate = DateTime.fromMillisecondsSinceEpoch(
        docCreatedDate.millisecondsSinceEpoch);
    pendingNumber =
        data['pendingNumber'] == null ? 0 : int.parse(data['pendingNumber']);
    progressNumber =
        data['progressNumber'] == null ? 0 : int.parse(data['progressNumber']);
    closedNumber =
        data['closedNumber'] == null ? 0 : int.parse(data['closedNumber']);
  }
}
