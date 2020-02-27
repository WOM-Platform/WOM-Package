import 'bounding_box.dart';

class SimpleFilters {
  static String AIM = "aim";
  static String BOUNDS = "bounds";
  static String MAX_AGE = "maxAge";

  String aimCode;
  BoundingBox bounds;
  int maxAge;

  SimpleFilters({this.aimCode, this.bounds, this.maxAge});

  SimpleFilters.fromJson(Map<String, dynamic> json) {
    aimCode = json[AIM];
    bounds =
        json[BOUNDS] != null ? new BoundingBox.fromJson(json[BOUNDS]) : null;
    maxAge = json[MAX_AGE];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[AIM] = this.aimCode;
    if (this.bounds != null) {
      data[BOUNDS] = this.bounds.toMap();
    }
    data[MAX_AGE] = this.maxAge;
    return data;
  }

  int get maxAgeToMilliseconds => maxAge * 86400000;

  @override
  String toString() {
    return "Data required, aim: $aimCode, bounds: ${bounds.toString()}, maxAge: $maxAge";
  }
}
