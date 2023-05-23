import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller1;
  Animation animation1;
  Animation animation2;
  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn);
    controller1.reverse(from: 1);
    animation1.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        controller1.forward();
      }
      //print(status);
    });
    // if (animation1.isCompleted) {
    //   controller1.reverse(from: 1);
    // } else if (animation1.isDismissed) {
    //   controller1.forward();
    // }
    animation2 =
        ColorTween(begin: Colors.yellowAccent.shade200, end: Colors.white)
            .animate(controller1);

    animation2.addListener(() {
      //print(animation2.value);
      //setState(() {});
    });
    animation1.addListener(
      () {
        setState(() {
          //print(animation1.value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation2.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),
                  height: animation1.value * 100,
                ),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText('Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 100)),
                ])
                // Text(
                //   'Flash Chat',
                //   style: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
