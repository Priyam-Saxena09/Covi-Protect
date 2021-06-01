import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:covi_protect/Notify/notification_helper.dart';

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
  DateTime last;
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
        updateLocation();
      });
    }
  }

  void updateLocation() async {
    if (name != null) {
      userStore
          .collection("Users")
          .document(name)
          .updateData({"Location": GeoPoint(lat, lon)});
      userStore
          .collection("Users")
          .getDocuments()
          .then((QuerySnapshot snap) => snap.documents.forEach((element) {
                //print(getDistance(element.data["Location"].latitude ,26.2187463, element.data["Location"].longitude, 81.8205575));
                if (element.data["Name"] != name && element.data["LoggedIn"]) {
                  double c = getDistance(lat, element.data["Location"].latitude,
                      lon, element.data["Location"].longitude);
                  bool flag = false;
                  if (c < 2.0) {
                    for (int i = 0; i < nearby_users.length; i++) {
                      if (nearby_users[i].containsKey(element.data["Name"])) {
                        var d = DateTime.now();
                        DateTime t = Timestamp.fromDate(d).toDate();
                        nearby_users[i][element.data["Name"]] = t;
                        flag = true;
                        last=t;
                        break;
                      }
                    }
                    if (!flag) {
                      var d = DateTime.now();
                      DateTime t = Timestamp.fromDate(d).toDate();
                      var m = new Map();
                      m[element.data["Name"]] = t;
                      last=t;
                      nearby_users.add(m);
                    }
                    userStore
                        .collection("Nearby_Users")
                        .document(name)
                        .updateData({"nearby_users": nearby_users});
                  }
                }
              }));
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

  double getDistance(double lat1, double lat2, double lon1, double lon2) {
    lat1 = radians(lat1);
    lat2 = radians(lat2);
    lon1 = radians(lon1);
    lon2 = radians(lon2);
    double dlon = radians(lon2 - lon1);
    double dlat = radians(lat2 - lat1);
    double a =
        pow(sin(dlat / 2), 2) + pow(sin(dlon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return c * 6371.0 * 1000.0;
  }

  void delete_users() {
    DateTime d;
    int dif;
    List<Object> nearby;
    if(name!=null)
      {
        userStore.collection("Nearby_Users").document(name).get().then((value) =>
        {
          for(int i = 0; i < value.data["nearby_users"].length; i++)
            {
              for(var n in value.data["nearby_users"][i].values)
                {
                  d = DateTime.now(),
                  dif = d.difference(n.toDate()).inDays,
                  if (dif >= 3)
                    {
                      nearby = [],
                      for(int j=0;j<nearby_users.length;j++)
                        {
                          if(nearby_users[j].toString() !=  value.data["nearby_users"][i].toString())
                            {
                              nearby.add(nearby_users[j]),
                            }
                        },
                      userStore
                          .collection("Nearby_Users")
                          .document(name)
                          .updateData({"nearby_users": nearby})
                    }
                }
            }

        });
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
  void get_Covid_nearby() {
    if (name != null) {
      userStore
          .collection("Nearby_Users")
          .document(name)
          .get()
          .then((value) => {
                for (int i = 0; i < value.data["nearby_users"].length; i++)
                  {
                    for (var nm in value.data["nearby_users"][i].keys)
                      {
                        userStore
                            .collection("Users")
                            .document(nm)
                            .get()
                            .then((d) => {
                                  if (d.data["Covid_Status"] && !covid_users.contains(nm))
                                    {
                                      covid_users.add(nm),
                                      showOngoingNotification(notifications,
                                          title: "Alert!",
                                          body: "${nm} is Covid +ve")
                                    }
                                })
                      }
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    delete_users();
    get_Covid_nearby();
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
                child: Text("Welcome ${name != null ? name : ""}",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Londrina Solid',
                    color: Colors.redAccent,
                  ),
                ),
              )
            ),
            SizedBox(
              height: 35.0,
            ),
            FlatButton(
              onPressed: () {
                var n = name;
                name=null;
                userStore
                    .collection("Users")
                    .document(n)
                    .updateData({"LoggedIn": false});
                _auth.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Sign Out"),
              color: Colors.black45,
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
                                  msg: "All your nearby users will get notified.Get well soon.Take care.",
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
                child: Text(last==null?"As of now, There are no nearby users":
                "Last time,You meet a person at ${last}",style: TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Londrina Solid',
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
