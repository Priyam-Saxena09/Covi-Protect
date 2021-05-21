import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  double lat = 0.0;
  double lon = 0.0;
  final userStore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  var nearby_users = [];
  Future<Position> getCor() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    if(name!=null) {
      setState(() {
        print(position);
        lat = position.latitude;
        lon = position.longitude;
        updateLocation();
      });
    }
  }
  void updateLocation()async{
    if(name!=null)
    {
     userStore.collection("Users").document(name).updateData({
        "Location": GeoPoint(lat,lon)
      });
     userStore.collection("Users").getDocuments().then((QuerySnapshot snap)
     => snap.documents.forEach((element) {
       print(getDistance(element.data["Location"].latitude ,26.0, element.data["Location"].longitude, 81.0));
       if(element.data["Name"]!=name && element.data["LoggedIn"] && nearby_users.indexOf(element.data["Name"])==-1)
       {
         print(getDistance(lat,element.data["Location"].latitude , lon, element.data["Location"].longitude));
         if(getDistance(lat,element.data["Location"][0] , lon, element.data["Location"][1])<2000.0)
           {
             nearby_users.add(element.data["Name"]);
             userStore.collection("Nearby_Users").document(name).updateData({
               "nearby_users":nearby_users
             });
           }
       }
     }));
    }
  }
  void getUser()
  async{
    final user = await _auth.currentUser();
    if(user!=null)
      {
        name = user.displayName;
        print(name);
        await userStore.collection("Users").document(name).updateData({
          "LoggedIn": true
        });
        userStore.collection("Nearby_Users").getDocuments()
            .then((QuerySnapshot) => QuerySnapshot.documents.forEach((element) {
              if(element.data["Name"]==name)
                {
                  nearby_users = element.data["nearby_users"];
                }
        })
        );
      }
  }
  double getDistance(double lat1, double lat2, double lon1, double lon2)
  {
    lat1 = radians(lat1);
    lat2 = radians(lat2);
    lon1 = radians(lon1);
    lon2 = radians(lon2);
    double dlon = lon2 - lon1;
    double dlat = lat2 - lat1;
    double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2),2);
    double c = 2 * asin(sqrt(a));
    return c*6371*1000;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    getCor();
    print(name);
    print(nearby_users);
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
              name!=null?name:"",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            FlatButton(onPressed: ()
            {
              userStore.collection("Users").document(name).updateData({
                "LoggedIn": false
              });
              _auth.signOut();
              Navigator.pop(context);
              Navigator.pop(context);
            }, child: Text("Sign Out"),color: Colors.black45,)
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
