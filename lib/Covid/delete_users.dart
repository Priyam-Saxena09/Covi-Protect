class Del {
  static void delete_users(name, userStore, nearby_users) {
    DateTime d;
    int dif;
    List<Object> nearby;
    if (name != null) {
      userStore
          .collection("Nearby_Users")
          .document(name)
          .get()
          .then((value) => {
                for (int i = 0; i < value.data["nearby_users"].length; i++)
                  {
                    for (var n in value.data["nearby_users"][i].values)
                      {
                        d = DateTime.now(),
                        dif = d.difference(n.toDate()).inDays,
                        if (dif >= 3)
                          {
                            nearby = [],
                            for (int j = 0; j < nearby_users.length; j++)
                              {
                                if (nearby_users[j].toString() !=
                                    value.data["nearby_users"][i].toString())
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
}
