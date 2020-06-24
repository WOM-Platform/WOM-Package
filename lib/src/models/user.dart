import 'package:wom_package/src/models/merchant.dart';

import 'actor.dart';

class User {
  static String dbPrivateKey = 'privateKey';
  static String dbId = 'id';

//  static String dbPublicKey = 'publicKey';
  static String dbUrl = 'url';
  static String dbName = 'name';
  static String dbSurname = 'surname';

  final List<Actor> actors;
  final List<Merchant> merchants;
  final String name;
  final String surname;

  User(
    this.name,
    this.surname,
    this.actors,
    this.merchants,
  );

//  User.fromMap(Map<String, dynamic> map, String actorKey)
//      : this.name = map['name'],
//        this.surname = map['surname'],
//       this.actors = List.from<>(map[actorKey]);
}
