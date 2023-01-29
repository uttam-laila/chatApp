import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn().then((value) {
        log(value?.displayName ?? '');
        log(value?.email ?? '');
        log(value?.id ?? '');
        log(value?.photoUrl ?? '');
        return users
            .add({
              'name': value?.displayName, // John Doe
              'email': value?.email, // Stokes and Sons
              'id': value?.id, // 42
              'photoUrl': value?.photoUrl,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    } catch (error) {
      print(error);
    }
  }

  Future<List> getData() async {
    var value =
        users.where('name', isEqualTo: 'uttam.laila@gmail.com').snapshots();
    // return await users.get().then((data) async {
    //   log(data.docs.last.id);
    // return await data;
    // }).onError((error, stackTrace) => throw error!);
//     final specificDocument = snapshot.data.documents.where((f) {
//      return f.documentID == _myMobile;
// }).toList();

    try {
      QuerySnapshot querySnapshot = await value.first;

      List data = [];
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        data.add(doc.data());
      });
      return data;
    } catch (error) {
      rethrow;
    }
  }

  PageController pageController = PageController(viewportFraction: 0.8);

  var currentIndex = 0.obs;

  void setCurrentIndex(int index) => currentIndex.value = index;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
}
