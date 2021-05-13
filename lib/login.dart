import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Log In",style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: "Texturina",
            fontSize: 65.0,
            color: Colors.purple
          ),),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.cyan,
              hintText: "Enter Email Id",
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))
              ),
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
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.cyan,
          hintText: "Enter Password",
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(16.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
    ),
        ],
      ),
    );
  }
}
