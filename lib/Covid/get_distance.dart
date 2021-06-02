import 'package:vector_math/vector_math.dart';
import 'dart:math';

class Distance {
  static double getDistance(
      double lat1, double lat2, double lon1, double lon2) {
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
}
