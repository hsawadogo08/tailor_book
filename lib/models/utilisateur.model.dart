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
}
