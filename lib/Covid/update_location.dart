import 'package:cloud_firestore/cloud_firestore.dart';
import 'get_distance.dart';

class Update {
  static void updateLocation(
      name, userStore, nearby_users, lat, lon, last) async {
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
                  double c = Distance.getDistance(
                      lat,
                      element.data["Location"].latitude,
                      lon,
                      element.data["Location"].longitude);
                  bool flag = false;
                  if (c < 2.0) {
                    for (int i = 0; i < nearby_users.length; i++) {
                      if (nearby_users[i].containsKey(element.data["Name"])) {
                        var d = DateTime.now();
                        DateTime t = Timestamp.fromDate(d).toDate();
                        nearby_users[i][element.data["Name"]] = t;
                        flag = true;
                        last.clear();
                        last.add(t);
                        break;
                      }
                    }
                    if (!flag) {
                      var d = DateTime.now();
                      DateTime t = Timestamp.fromDate(d).toDate();
                      var m = new Map();
                      m[element.data["Name"]] = t;
                      last.clear();
                      last.add(t);
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
}
