import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final databaseReference = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser!;

class storeData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required String name,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String resp = "Some Error Occured";
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('profileImage', file);
        // databaseReference.child(user.email!).set({
        //   'name': name,
        //   'username': username,
        //   'bio': bio,
        //   'imageLink': imageUrl
        // });
        await _firestore.collection('Users').doc(user.email!).set({
          'name': name,
          'username': username,
          'bio': bio,
          'imageLink': imageUrl
        });
        resp = "Success";
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }

  
  Future<String> savePostData(
      {required String caption,
       required String name,
       required String userImage,
      required Uint8List file}) async {
    String resp = "Some Error Occured";
    try {
      if (caption.isNotEmpty || caption.isNotEmpty) {
        final id=Timestamp.now();
        String imageUrl = await uploadImageToStorage('${id}+postImage', file);
        // databaseReference.child(user.email!).set({
        //   'name': name,
        //   'username': username,
        //   'bio': bio,
        //   'imageLink': imageUrl
        // });
        await _firestore.collection('UsersPost').add({
          'name': name,
          'caption':caption,
          'imageLink': imageUrl,
          'userImage':userImage,
          'timestamp': Timestamp.now(),
        });
        resp = "Success";
      }
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}
