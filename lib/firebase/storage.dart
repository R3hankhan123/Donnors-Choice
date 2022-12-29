import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImageToStorage(
    String childName,
    Uint8List file,
  ) async {
    try {
      final UploadTask uploadTask =
          _storage.ref().child('Profile Pics').child(childName).putData(file);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = (await downloadUrl.ref.getDownloadURL());
      return url;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
