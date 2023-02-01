// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PhotoService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String?> savePhoto(XFile photo, String type) async {
    final fileName = basename(photo.path);
    final destination = '$type/$fileName';
    var file = File(photo.path);
    try {
      TaskSnapshot taskSnapshot = await firebase_storage
          .FirebaseStorage.instance
          .ref(destination)
          .putFile(file);

      if (taskSnapshot.state == TaskState.success) {
        try {
          String downloadURL =
              await FirebaseStorage.instance.ref(destination).getDownloadURL();
          return downloadURL;
        } on Exception catch (_, e) {
          log("GetdownloadURL Error: $e");
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (_, e) {
      log("SaveFile Error: $e");
      return null;
    }
  }

  static Future<String?> uploadFile(XFile imagePicker) async {
    File photo = File(imagePicker.path);
    final fileName = basename(photo.path);
    final destination = 'models/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      UploadTask uploadTask = ref.putFile(photo);
      uploadTask.whenComplete(() async {
        try {
          String url = await ref.getDownloadURL();
          log("URL ===> $url");
          return url;
        } on Exception catch (_, e) {
          log("Error ==> $e");
          return null;
        }
      });
    } catch (e) {
      log('error occured');
      return null;
    }
  }
}
