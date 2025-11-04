import 'dart:developer';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialog_utils.dart';
import 'package:evently_c16/core/source/remote/firestore_service.dart';
import 'package:evently_c16/models/my_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
//! register method
  static createAccount({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
  }) async {
    try {
      DialogUtils.showLoadingDialog(context);
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser user = MyUser(
        id: credential.user?.uid,
        name: nameController.text,
        email: emailController.text,
      );
      FirestoreService.addUser(user);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesManager.homeScreen,
        (route) => false,
      );
      log("Create Account Success");
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(
          context: context,
          message: 'The password provided is too weak.',
          positiveActionTitle: 'Ok',
          positiveActionPress: () {
            Navigator.pop(context);
          },
        );
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(
          context: context,
          message: 'The account already exists for that email.',
          positiveActionTitle: 'Ok',
          positiveActionPress: () {
            Navigator.pop(context);
          },
        );
        log('The account already exists for that email.');
      }
    } catch (error) {
      Navigator.pop(context);
      DialogUtils.showMessageDialog(
        context: context,
        message: error.toString(),
        positiveActionTitle: 'Ok',
        positiveActionPress: () {
          Navigator.pop(context);
        },
      );
      log(error.toString());
    }
  }

//! sign in method
  static signin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      DialogUtils.showLoadingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, RoutesManager.homeScreen);
      log(credential.user!.email!);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showMessageDialog(
          context: context,
          message: 'No user found for that email.',
          positiveActionTitle: 'Ok',
          positiveActionPress: () {
            Navigator.pop(context);
          },
        );
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMessageDialog(
          context: context,
          message: 'Wrong password provided for that user.',
          positiveActionTitle: 'Ok',
          positiveActionPress: () {
            Navigator.pop(context);
          },
        );
        log('Wrong password provided for that user.');
      }
    }
  }
}
