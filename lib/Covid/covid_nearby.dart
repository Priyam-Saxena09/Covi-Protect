import 'package:covi_protect/Notify/notification_helper.dart';

class Nearby {
  static void get_Covid_nearby(name, userStore, covid_users, notifications) {
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
                                  if (d.data["Covid_Status"] &&
                                      !covid_users.contains(nm))
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
}
