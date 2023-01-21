import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tailor_book/models/customer.model.dart';
import 'package:tailor_book/services/sharedPrefConfig.dart';
import 'package:tailor_book/services/sharedPrefKeys.dart';

class CustomerService {
  static CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  // ignore: slash_for_doc_comments
  /**
  // *   Save Customer
  // [customer] is the object of Customer to save
  */
  static Future<String> save(Customer customer) async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      userUID = "MDL1Hd2dsSQxPEPTgouzogfTL8B2";
      // throw Exception("Le compte est introuvable !");
    }
    customer.userUID = userUID;
    DocumentReference savedDoc = await customers.add(customer.toMap());
    return savedDoc.id;
  }

  static Future<QuerySnapshot<Object?>> getAll() async {
    String userUID =
        await SharedPrefConfig.getStringData(SharePrefKeys.JWT_TOKEN);

    if (userUID == "") {
      userUID = "MDL1Hd2dsSQxPEPTgouzogfTL8B2";
      // throw Exception("Le compte est introuvable !");
    }
    return await customers.where("userUID", isEqualTo: userUID).get();
  }
}
