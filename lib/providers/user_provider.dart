import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/my_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;

  getUser() async {
    user =
        await FirestoreService.getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }
}
