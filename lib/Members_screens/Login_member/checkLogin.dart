import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneal_admin_panel/Admin_screens/Login/login_page.dart';
import 'package:oneal_admin_panel/Admin_screens/welcome_back_screen.dart';
import 'package:oneal_admin_panel/Members_screens/Login_member/login_member_page.dart';

import '../home_member_page.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return WelcomeBack();
            } else if (snapshot.hasError) {
              return LogIn();
            } else {
              return LogIn();
            }
          }),
    ));
  }
}
