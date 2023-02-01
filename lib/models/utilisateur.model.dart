import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  String? userUID;
  String? lastName;
  String? firstName;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  String? companyName;

  Utilisateur({
    this.userUID = '',
    this.lastName = '',
    this.firstName = '',
    this.phoneNumber = '',
    this.email = '',
    this.companyName = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "UID": userUID,
      "companyName": companyName,
      "lastName": lastName,
      "firstName": firstName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };
  }

  Utilisateur.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    userUID = doc.id;
    companyName = data["companyName"];
    lastName = data["lastName"];
    firstName = data["firstName"];
    phoneNumber = data["phoneNumber"];
    email = data["email"];
    password = data["password"];
  }

  Utilisateur.fromMap(Map<String, dynamic> map) {
    userUID = map["UID"];
    companyName = map["companyName"];
    lastName = map["lastName"];
    firstName = map["firstName"];
    phoneNumber = map["phoneNumber"];
    email = map["email"];
    password = map["password"];
  }
}
