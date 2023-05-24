import 'package:flutter/material.dart';

class LoginAnimations {
  //Duration secondss;
  AnimationController controller1;
  Animation curveAnimation;
  Animation textAnimation;
  LoginAnimations(this.controller1);
  Animation curveAnime(Curve cAnime) {
    curveAnimation = CurvedAnimation(parent: controller1, curve: cAnime);
    controller1.reverse(from: 1);
    curveAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        controller1.forward();
      }
    });
    return curveAnimation;
  }

  Animation textAnime(Color tBigin, Color tEnd) {
    return textAnimation =
        ColorTween(begin: tBigin, end: tEnd).animate(controller1);
  }
}
