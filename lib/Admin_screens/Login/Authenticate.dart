import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneal_admin_panel/Admin_screens/Login/login_page.dart';
import 'package:oneal_admin_panel/Admin_screens/welcome_back_screen.dart';
import 'package:oneal_admin_panel/Members_screens/Login_member/checkLogin.dart';

class Authentications extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return WelcomeBack();
    } else {
      return CheckLogin();
    }
  }
}
