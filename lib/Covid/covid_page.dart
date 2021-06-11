import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covi_protect/About%20and%20Help/about.dart';
import 'package:covi_protect/Covid/update_location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../About and Help/help.dart';
import 'covid_nearby.dart';
import 'delete_users.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  final notifications = FlutterLocalNotificationsPlugin();
  double lat = 0.0;
  double lon = 0.0;
  final userStore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  List<DateTime> last = [];
  var nearby_users = [];
  List<String> covid_users = [];
  Future<Position> getCor() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    if (name != null) {
      setState(() {
        print(position);
        lat = position.latitude;
        lon = position.longitude;
        Update.updateLocation(name, userStore, nearby_users, lat, lon, last);
      });
    }
  }
  void getUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      name = user.displayName;
      //print(name);
      await userStore
          .collection("Users")
          .document(name)
          .updateData({"LoggedIn": true});
      userStore
          .collection("Nearby_Users")
          .getDocuments()
          .then((QuerySnapshot) => QuerySnapshot.documents.forEach((element) {
                if (element.data["Name"] == name) {
                  nearby_users.addAll(element.data["nearby_users"]);
                }
              }));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    final settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    Fluttertoast.showToast(
        msg: "Please Isolate Yourself.Stay safe and Stay Healthy.",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 4,
        backgroundColor: Colors.black54,
        textColor: Colors.blueAccent);
  }

  @override
  Widget build(BuildContext context) {
    Del.delete_users(name, userStore, nearby_users);
    Nearby.get_Covid_nearby(name, userStore, covid_users, notifications);
    getCor();
    //print(name);
    //print(nearby_users);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
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
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                color: Colors.indigo,
                width: double.infinity,
                height: 125.0,
                child: Center(
                  child: Text(
                    "Welcome ${name != null ? name : ""}",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Londrina Solid',
                      color: Colors.redAccent,
                    ),
                  ),
                )),
            SizedBox(
              height: 35.0,
            ),
            FlatButton(
              minWidth: 250.0,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return About();
                }));
              },
              child: Text(
                "About",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
            SizedBox(
              height: 35.0,
            ),
            FlatButton(
              minWidth: 250.0,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Help();
                }));
              },
              child: Text(
                "Help",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
            SizedBox(
              height: 35.0,
            ),
            FlatButton(
              minWidth: 250.0,
              onPressed: () {
                String n = name;
                name=null;
                _auth.signOut();
                userStore
                    .collection("Users")
                    .document(n)
                    .updateData({"LoggedIn": false});
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            )
          ],
        ),
      ),
      body: Opacity(
        opacity: 0.65,
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/Corona.jpg"),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                      "Note:Press the Below Button if you are Covid Positive",
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black,
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
                    Alert(
                        context: context,
                        title: "Covid Status Check",
                        desc: "Are you sure about your Covid Status?",
                        buttons: [
                          DialogButton(
                              child: Text("Yes"),
                              onPressed: () {
                                userStore
                                    .collection("Users")
                                    .document(name)
                                    .updateData({"Covid_Status": true});
                                Fluttertoast.showToast(
                                    msg:
                                        "All your nearby users will get notified.Get well soon.Take care.",
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 4,
                                    backgroundColor: Colors.black54,
                                    textColor: Colors.blueAccent);
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ]).show();
                  },
                ),
                SizedBox(
                  height: 90.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.0),
                  child: Text(
                    last.isEmpty
                        ? "As of now, There are no nearby users"
                        : "Last time,You meet a person at ${last[0]}",
                    style: TextStyle(
                      fontSize: 55.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Londrina Solid',
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
