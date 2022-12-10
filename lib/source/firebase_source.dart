import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

class FirebaseSource {
  final _firestore = FirebaseFirestore.instance;
  final _currentUserUid = FirebaseAuth.instance.currentUser?.uid;
  final _firebaseStorage = FirebaseStorage.instance;

  Future<bool> createUser(UserReqResModel userReq) async {
    bool isUserCreated = false;
    try {
      final doc = await _firestore
          .collection(CollectionKeys.users)
          .doc(_currentUserUid)
          .get();

      if (doc.exists) return isUserCreated = true;
      _firestore
          .collection("Users")
          .doc(_currentUserUid)
          .set(userReq.toJson())
          .then((value) => isUserCreated = true);
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUserCreated;
  }

  Stream<UserReqResModel> fetchCurrentUser() {
    return _firestore
        .collection(CollectionKeys.users)
        .doc(_currentUserUid)
        .snapshots()
        .map((event) {
      return UserReqResModel.fromJson(event.data()!);
    });
  }

  Future<String> getImageUrl(XFile file) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('images/$_currentUserUid')
        .putFile(File(file.path));
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> updateProfilePic(String profilePic) async {
    return await _firestore
        .collection(CollectionKeys.users)
        .doc(_currentUserUid)
        .update({"profile_pic": profilePic});
  }

  Future<void> updateNameOrPhone(
    String? name,
    String? phoneNumber,
  ) async {
    final fieldToBeUpdate =
        phoneNumber != null ? {"whatsapp_Number": phoneNumber} : {"name": name};
    return _firestore
        .collection(CollectionKeys.users)
        .doc(_currentUserUid)
        .update(fieldToBeUpdate);
  }

  Future<void> updateAbout(String? about) async {
    return _firestore
        .collection(CollectionKeys.users)
        .doc(_currentUserUid)
        .update({"about": about});
  }

  Future<bool> isUserAlreadyExist() async {
    final doc = await _firestore
        .collection(CollectionKeys.users)
        .doc(_currentUserUid)
        .get();
    return doc.exists;
  }
}
