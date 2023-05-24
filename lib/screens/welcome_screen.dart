import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'animations.dart';
import 'package:flash_chat/components/buttons.dart';
//import 'package:cool_alert/cool_alert.dart';

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
    LoginAnimations la = LoginAnimations(controller1);

    // animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn);
    // controller1.reverse(from: 1);
    // animation1.addStatusListener((status) {
    //   if (status == AnimationStatus.dismissed) {
    //     controller1.forward();
    //   }
    // });
    animation1 = la.curveAnime(Curves.easeIn);
    animation2 = la.textAnime(Colors.yellowAccent.shade200, Colors.white);
    // animation2 =
    //     ColorTween(begin: Colors.yellowAccent.shade200, end: Colors.white)
    //         .animate(controller1);

    // animation2.addListener(() {
    //   setState(() {});
    // });
    animation1.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
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
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LoginButtons('Log In', Colors.lightBlueAccent, () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            LoginButtons('Register', Colors.blueAccent, () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
          ],
        ),
      ),
    );
  }
}
