import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getCor();
  }
  Future<Position> getCor()
  async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      print(position);
      lat = position.latitude;
      lon = position.longitude;
    });
  }
  double lat;
  double lon;
  @override
  Widget build(BuildContext context) {
    getCor();
    print(lat);
    print(lon);
    return Column(
      children:[ Container(
        child: Text(this.lat.toString()),
      ),Container(
    child: Text(this.lon.toString()))],
    );
  }
}

