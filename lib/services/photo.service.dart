import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';

class PhotoService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> savePhoto(XFile photo, String type) async {
    final firebaseStorage = FirebaseStorage.instance;
    final fileName = basename(photo.path);
    var file = File(photo.path);
    var snapshot =
        firebaseStorage.ref().child('models/$fileName').putFile(file);
    try {
      String url = await snapshot.snapshot.ref.getDownloadURL();
      log("URL ==> $url");
      return url;
    } on Exception catch (_, e) {
      log("ERROR => $e");
      return "";
    }
    // return snapshot.snapshot.ref.getDownloadURL();

    // final destination = 'models/$fileName';
    // final ref = storage.ref().child("models/test.png");
    // ref.putFile(File(photo.path));
    // return ref.getDownloadURL();
  }
}
