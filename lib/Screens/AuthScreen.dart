import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import 'HomeScreen.dart';
import 'SignInScreen.dart';

class AuthScreen extends StatelessWidget {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return HomeScreen();
              }
            } else {
              return SignInScreen();
            }
          }),
    );
  }
}
