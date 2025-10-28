import 'dart:developer';

import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/source/remote/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  GoogleAuthService authService = GoogleAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
