import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oneal_admin_panel/Admin_screens/welcome_back_screen.dart';
import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String phoneNo, smssent, verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {});
    } as PhoneCodeSent;
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {};
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: Duration(seconds: 60),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var errorController;
        return AlertDialog(
          title: Text('Provide OTP'),
          content: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            errorAnimationController: errorController,
            // Pas// s it here
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                this.smssent = value;
              });
            },
            appContext: context,
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeBack()),
                    );
                  } else {
                    // showDialog(
                    //   context: context,
                    //   builder: (_) => AlertDialog(
                    //     content: Text('Wrong OTP'),
                    //   ),
                    // );
                    Navigator.of(context).pop();
                    signIn(smssent);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Phone Login'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Phone number',
              ),
              onChanged: (value) {
                this.phoneNo = value;
              },
            ),
          ),
          SizedBox(height: 10.0),
          // RaisedButton(
          //   onPressed: verifyPhone,
          //   child: Text(
          //     'Verify',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   elevation: 7.0,
          //   color: Colors.blue,
          // )
        ],
      ),
    );
  }
}
