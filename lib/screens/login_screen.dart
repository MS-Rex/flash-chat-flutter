import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/styles/TextDecorations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:alert/alert.dart';
//import 'package:cool_alert/cool_alert.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String logemail;
  late String logPasswd;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'flash_logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                logemail = value;
              },
              decoration:
                  textDecoration('Enter your Email', Colors.lightBlueAccent),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                logPasswd = value;
              },
              decoration:
                  textDecoration('Enter your Password', Colors.lightBlueAccent),
            ),
            SizedBox(
              height: 24.0,
            ),
            LoginButtons('Log In', Colors.lightBlueAccent, () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: logemail, password: logPasswd);
                if (user != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  Alert(message: 'Wrong Password !\n Try Again').show();
                  // CoolAlert.show(
                  //   context: context,
                  //   type: CoolAlertType.error,
                  //   text: "Incorrect Password! ",
                  // );
                  print(e.code);
                  //return mms(context);
                }
                //print(e);
              }
            }),
          ],
        ),
      ),
    );
  }
}
