import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Upload Profile Image + Update Firestore
  Future<String?> uploadProfilePhoto(File file) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      // Storage path: users/userId/profile.jpg
      final ref = _storage.ref().child("users/${user.uid}/profile.jpg");

      // Upload file
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({"photoUrl": downloadUrl});

      return downloadUrl;
    } catch (e) {
      print("UPLOAD ERROR: $e");
      return null;
    }
  }
}
