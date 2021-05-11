import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Find(),
    );
  }
}
class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Future<Position> getCor()
  async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      print(position);
      lat = position.latitude;
      lon = position.longitude;
    });
  }
  double lat = 0.0;
  double lon = 0.0;
  @override
  Widget build(BuildContext context) {
    getCor();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Welcome to Covi-Protect",style: TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400
          ),),
        ),
      ),
      body: Opacity(
        opacity: 0.5,
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/istock.jpg"),
                  fit: BoxFit.fill,
            )
          ),
          child: Column(
            children:[ Container(
              child: Text(this.lat.toString(),style: TextStyle(
                  fontSize: 37.0,
                  color: Colors.lightGreenAccent,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900
              )),
            ),Container(
          child: Text(this.lon.toString(),style: TextStyle(
              fontSize: 37.0,
              color: Colors.lightGreenAccent,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900)))],
          ),
        ),
      ),
    );
  }
}

