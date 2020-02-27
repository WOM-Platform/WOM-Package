class BoundingBox {
  static String LEFT_TOP = "leftTop";
  static String LEFT_TOP_LAT = "leftTopLat";
  static String LEFT_TOP_LONG = "leftTopLong";
  static String RIGHT_BOT = "rightBottom";
  static String RIGHT_BOT_LAT = "rightBottomLat";
  static String RIGHT_BOT_LONG = "rightBottomLong";

  List<double> leftTop;
  List<double> rightBottom;

  BoundingBox({this.leftTop, this.rightBottom});

  BoundingBox.fromJson(Map<String, dynamic> json) {
    leftTop = json[LEFT_TOP].cast<double>();
    rightBottom = json[RIGHT_BOT].cast<double>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[LEFT_TOP] = leftTop;
    data[RIGHT_BOT] = rightBottom;
    return data;
  }

  @override
  String toString() {
    return "LT: ${leftTop[0].toStringAsFixed(2)},${leftTop[1].toStringAsFixed(2)};\n"
        "RB: ${rightBottom[0].toStringAsFixed(2)},${rightBottom[1].toStringAsFixed(2)}";
  }
}
