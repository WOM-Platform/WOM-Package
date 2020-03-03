import 'actor.dart';

class Instrument extends Actor {
  Instrument(String id, String name, String url, String privateKey)
      : super(id, name, url, privateKey);

  Instrument.fromMap(map) : super.fromMap(map);
}
