import 'dart:convert';
import 'package:wom_package/src/models/actor.dart';
import 'package:wom_package/src/models/instrument.dart';
import 'package:wom_package/src/models/pos.dart';
import 'package:wom_package/src/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:wom_package/src/models/user_type.dart';
import '../../http_helper.dart';

class UserRepository {
  final UserType _userType;
  final secureStorage = FlutterSecureStorage();

  UserRepository(this._userType);

  Future<User> authenticate({
    String username,
    String password,
  }) async {
    try {
      final bytes = utf8.encode('$username:$password');
      final base64String = Base64Encoder().convert(bytes);
      final type = this._userType == UserType.Instrument ? 'sources' : 'pos';
      final body = await HttpHelper.authenticate(base64String, type);
      final map = json.decode(body);
      List<Actor> actors;
      if (this._userType == UserType.Instrument) {
        actors = map[type]
            .map((instrument) => Instrument.fromMap(instrument))
            .toList();
      } else {
        actors = map[type].map((pos) => Pos.fromMap(pos)).toList();
      }
      return User(map[User.dbName], map[User.dbSurname], actors);
    } catch (ex) {
      throw ex;
    }
  }

  Future<void> deleteToken() async {
    final mmkv = await MmkvFlutter.getInstance();
    await mmkv.clear();
    await secureStorage.delete(key: 'actors');
  }

  Future<void> persistToken(User user) async {
    final mmkv = await MmkvFlutter.getInstance();
    mmkv.setString(User.dbName, user.name);
    mmkv.setString(User.dbSurname, user.surname);
    final array = user.actors.map((actor) => actor.toMap()).toList();
    final jsonArray = json.encode(array);
    await secureStorage.write(key: 'actors', value: jsonArray);
  }

  Future<User> readUser() async {
    final mmkv = await MmkvFlutter.getInstance();
    final name = await mmkv.getString(User.dbName);
    final surname = await mmkv.getString(User.dbSurname);
    final actorsJsonArray = await secureStorage.read(key: User.dbPrivateKey);
    final actorsArray = json.decode(actorsJsonArray);
    List<Actor> actors;
    if (this._userType == UserType.Instrument) {
      actors = actorsArray
          .map((instrument) => Instrument.fromMap(instrument))
          .toList();
    } else {
      actors = actorsArray.map((pos) => Pos.fromMap(pos)).toList();
    }
    return User(name, surname, actors);
  }

  Future<bool> hasToken() async {
//    String private = await secureStorage.read(key: User.dbPrivateKey);
    final mmkv = await MmkvFlutter.getInstance();
    final name = await mmkv.getString(User.dbName);
    final surname = await mmkv.getString(User.dbSurname);
    return name != null && surname != null;
  }
}
