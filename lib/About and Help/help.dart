import 'package:flutter/material.dart';
class Help extends StatelessWidget {
  const Help({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              Text("For More Information,Contact"),
              SizedBox(height: 16.0,),
              Row(children: [Icon(Icons.phone),
              SizedBox(width: 10.0,),
                Text("6379076631")
              ],),
              SizedBox(height: 16.0,),
              Row(children: [Icon(Icons.email),
                SizedBox(width: 10.0,),
                Text("priyamsaxena2k@gmail.com")
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
