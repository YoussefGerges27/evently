import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppConstants.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/resources/dialog_utils.dart';
import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/source/remote/firbase_auth_service.dart';
import 'package:evently_c16/core/source/remote/google_auth_service.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/reusable_components/CustomField.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String selectedLanguage = "en";
  final auth = GoogleAuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController(text: 'youssef@gmail.com');
    passwordController = TextEditingController(text: '12345678');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  SizedBox(
                    height: 24,
                  ),
                  CustomField(
                    hint: "email".tr(),
                    prefix: AssetsManager.email,
                    controller: emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email shouldn't be empty";
                      }
                      var regex = RegExp(emailRegex);
                      if (!regex.hasMatch(value)) {
                        return "Email isn't valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomField(
                    controller: passwordController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password shouldn't be empty";
                      }
                      if (value.length < 8) {
                        return "Password shouldn't be less than 8";
                      }
                      return null;
                    },
                    hint: "pass".tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "forgotPass".tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      title: "login".tr(),
                      onPress: () {
                        if (formKey.currentState?.validate() ?? false) {
                          FirebaseAuthService.signin(
                            context: context,
                            emailController: emailController,
                            passwordController: passwordController,
                          );
                        }
                      }),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dontHaveAccount".tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesManager.register);
                        },
                        child: Text(
                          "createAcc".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      Text(
                        "Or",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: ColorsManager.primaryColor,
                                ),
                      ),
                      Expanded(
                          child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final userCredential = await auth.signInWithGoogle();
                      if (userCredential != null) {
                        log("Signed in: ${userCredential.user?.displayName}");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesManager.homeScreen,
                          (route) => false,
                        );
                      } else {
                        log("Sign in cancelled or failed");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: BoxBorder.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsManager.googleLogo),
                          const SizedBox(width: 12),
                          Text(
                            "Login With Google",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomSwitch(
                    selected: selectedLanguage,
                    icon2: AssetsManager.eg,
                    icon1: AssetsManager.us,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      if (selectedLanguage == "ar") {
                        context.setLocale(Locale("ar"));
                      } else {
                        context.setLocale(Locale("en"));
                      }
                    },
                    values: ["en", "ar"],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
