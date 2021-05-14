import 'package:covi_protect/login.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign Up",
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
            textAlign: TextAlign.center,
            onChanged: (val) {
              name = val;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo,
                hintText: "Enter Your Name",
                hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.white),
                contentPadding: EdgeInsets.all(14.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)))),
          ),
          SizedBox(
            height: 25.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (val) {
              email = val;
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo,
                hintText: "Enter Your Email",
                hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.white),
                contentPadding: EdgeInsets.all(14.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)))),
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
                fillColor: Colors.indigo,
                hintText: "Enter Your Password",
                hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.white),
                contentPadding: EdgeInsets.all(14.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)))),
          ),
          SizedBox(
            height: 25.0,
          ),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text("Sign Up"),
            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
            onPressed: () {
              if (name == null || email == null || password == null) {
                Alert(
                    context: context,
                    title: "Wrong Input",
                    desc: "Please Enter all the fields",
                    buttons: [
                      DialogButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ]).show();
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }
            },
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already an app user?  ",
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: "Lobster",
                  color: Colors.lightBlueAccent,
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  color: Colors.blueAccent,
                  child: Text("Log In"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)))
            ],
          )
        ],
      ),
    );
  }
}
