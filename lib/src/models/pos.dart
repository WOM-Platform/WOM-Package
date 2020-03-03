import 'actor.dart';

class Pos extends Actor {
  Pos(String id, String name, String url, String privateKey)
      : super(id, name, url, privateKey);

  Pos.fromMap(map) : super.fromMap(map);
}
