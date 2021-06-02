import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Center(child: Text("About")),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.0),
        child: Text("Covi Protect is an app to aware each and "
            "every person about the covid status of the people who come "
            "at most 2 meters close to the person.The person who is covid"
            "positive will press the covid button to notify all the people"
            "who come close to that covid positive person. For more inform"
            "ation, Go to Help Page and contact on the given phone number or "
            "email id.",style: TextStyle(
          fontSize: 25.0,
          fontStyle: FontStyle.italic,
          fontFamily: "Lobster"
        ),),
    ),
      ));
  }
}
