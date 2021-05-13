import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Future<Position> getCor() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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
          child: Text(
            "Welcome to Covi-Protect",
            style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.indigo,
              width: double.infinity,
              height: 125.0,
              child: CircleAvatar(
                backgroundImage: AssetImage("images/istock.jpg"),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "Priyam Saxena",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
      body: Opacity(
        opacity: 0.73,
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/istock.jpg"),
            fit: BoxFit.fill,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                    "Note:Press the Below Button if you are Covid Positive",
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.deepPurple,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Texturina',
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 55.0,
              ),
              FlatButton(
                child: Text(
                  "COVID-19 +ve",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lobster',
                    color: Colors.indigo,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                height: 40.0,
                minWidth: 280.0,
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)),
                onPressed: () {
                  print("A");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
