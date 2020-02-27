//enum WomStatus { ON, OFF }
//
//class Wom {
//  static final tblWom = "wom";
//  static final dbId = "id";
//  static final dbSecret = "secret";
//  static const dbTimestamp = "timestamp";
//  static const dbLat = "latitude";
//  static const dbLong = "longitude";
//  static const dbLive = "live";
//  static const dbSourceName = "sourceName";
//  static const dbSourceId = "sourceId";
//  static const dbTransactionId = "transactionId";
//  static const dbAim = "aim";
//  static const dbCount = "count";
//
//  double latitude, longitude;
//  int id;
//  DateTime timestamp;
//  WomStatus live;
//  String sourceName;
//  int sourceId;
//  int transactionId;
//  String aim;
//  int count;
//
//  Wom(
//      {this.latitude,
//      this.longitude,
//      this.live,
//      this.id,
//      this.timestamp,
//      this.sourceId,
//      this.sourceName,
//      this.aim,
//      this.count});
//
//  Map<String, dynamic> toMap() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data[dbLat] = this.latitude;
//    data[dbLong] = this.longitude;
//    data[dbTimestamp] = this.timestamp.toIso8601String();
//    data[dbAim] = this.aim;
//    data[dbCount] = this.count;
//    return data;
//  }
//}
