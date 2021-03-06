import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covi_protect/Authorisation/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin{
  Animation animate;
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 7), vsync: this);
    animate = ColorTween(begin: Colors.teal, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
    new Timer(Duration(seconds: 8),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignUpPage();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:animate.value,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.0),
            child: TypewriterAnimatedTextKit(
      text: ["Welcome to Covi Protect"],
      textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: "Lobster",
            fontSize: 85.0,
            color: Colors.deepPurpleAccent,
      ),
    ),
          ),
        ));
  }
}
