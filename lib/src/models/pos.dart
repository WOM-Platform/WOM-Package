import 'actor.dart';

class Pos extends Actor {
  List<double> coordinates;
  Pos(String id, String name, String url, String privateKey, this.coordinates)
      : super(id, name, url, privateKey);

  Pos.fromMap(map) : super.fromMap(map) {
    coordinates = map['coordinates'];
  }
}
