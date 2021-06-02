import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Help extends StatelessWidget {
  const Help({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 185.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("For More Information,Contact",style:TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Texturina"
              ),),
              SizedBox(height: 16.0,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.phone),
              SizedBox(width: 13.0,),
                Text("6379076631",style:TextStyle(
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Texturina"
                ),)
              ],),
              SizedBox(height: 16.0,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.email),
                SizedBox(width: 13.0,),
                Text("priyamsaxena2k@gmail.com",style:TextStyle(
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Texturina"
                ),)
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
