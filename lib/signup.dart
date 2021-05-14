import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo,
                hintText: "Enter Your Name",
                hintStyle:
                    TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
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
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo,
                hintText: "Enter Your Email",
                hintStyle:
                    TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
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
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo,
                hintText: "Enter Your Password",
                hintStyle:
                    TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
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
            padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 15.0),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }
}
