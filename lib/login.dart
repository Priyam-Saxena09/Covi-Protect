import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:covi_protect/covid_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String email;
  String password;
  Animation animation;
  AnimationController controller;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.lightGreenAccent)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Log In",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: "Texturina",
                fontSize: 65.0,
                color: Colors.purple),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (val) {
              email = val;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.cyan,
              hintText: "Enter Email Id",
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (val) {
              password = val;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.cyan,
              hintText: "Enter Password",
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          RaisedButton(
            color: Colors.green,
            child: Text("Log In"),
            onPressed: () async{
              if (email == null || password == null) {
                Alert(
                    context: context,
                    title: "Wrong Input",
                    desc: "Please Enter all the fields.",
                    buttons: [
                      DialogButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.pop(context),
                      )
                    ]).show();
              } else {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user!=null) {
                    print(user);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Find();
                    }));
                  }
                } catch (e) {
                  Alert(
                      context: context,
                      title: "Wrong Input",
                      desc: "User Not Found.",
                      buttons: [
                        DialogButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ]).show();
                }
              }
            },
          )
        ],
      ),
    );
  }
}
