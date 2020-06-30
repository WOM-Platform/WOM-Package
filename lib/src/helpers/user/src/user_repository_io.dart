import 'dart:convert';
import 'package:wom_package/src/models/actor.dart';
import 'package:wom_package/src/models/instrument.dart';
import 'package:wom_package/src/models/merchant.dart';
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
      if (_userType == UserType.POS) {
        return authenticatePos(base64String: base64String);
      } else {
        return authenticateInstrument(base64String: base64String);
      }
    } catch (ex) {
      throw ex;
    }
  }

  Future<User> authenticateInstrument({String base64String}) async {
    final type = 'sources';
    final body = await HttpHelper.authenticate(base64String, type);
    final map = json.decode(body);
    final name = map[User.dbName];
    final surname = map[User.dbSurname];
    final email = map[User.dbEmail];
    List<Actor> actors = map[type]
        .map<Instrument>((instrument) => Instrument.fromMap(instrument))
        .toList();
    return User(name, surname, email, actors, []);
  }

  Future<User> authenticatePos({String base64String}) async {
    final body = await HttpHelper.authenticate(base64String, 'merchant');
    final map = json.decode(body);
    final name = map[User.dbName];
    final surname = map[User.dbSurname];
    final email = map[User.dbEmail];
    final merchants = List<Merchant>.from(
        map['merchants'].map<Merchant>((m) => Merchant.fromMap(m)));
    return User(name, surname, email, [], merchants);
  }

  Future<void> deleteToken() async {
    final mmkv = await MmkvFlutter.getInstance();
    await mmkv.clear();
    await secureStorage.delete(key: 'actors');
  }

  Future<void> persistToken(User user, String email, String password) async {
    final mmkv = await MmkvFlutter.getInstance();
    await mmkv.setString(User.dbName, user.name);
    await mmkv.setString(User.dbSurname, user.surname);
    await mmkv.setString(User.dbEmail, user.email);

    List<Map<String, dynamic>> array;
    if (_userType == UserType.Instrument) {
      array = user.actors.map((actor) => actor.toMap()).toList();
    } else {
      array = user.merchants.map((merchant) => merchant.toMap()).toList();
    }

    final jsonArray = json.encode(array);
    await secureStorage.write(key: 'actors', value: jsonArray);
    await secureStorage.write(key: 'password', value: password);
    await mmkv.setInt('lastLogin', DateTime.now().millisecondsSinceEpoch);
  }

  Future<User> readUser() async {
    final mmkv = await MmkvFlutter.getInstance();
    final name = await mmkv.getString(User.dbName);
    final surname = await mmkv.getString(User.dbSurname);
    final email = await mmkv.getString(User.dbEmail);
    if (name == null || surname == null || email == null) {
      return null;
    }

    final lastLogin =
        DateTime.fromMillisecondsSinceEpoch(await mmkv.getInt('lastLogin'));

    if (DateTime.now().difference(lastLogin).inMinutes > 3600) {
      final password = await secureStorage.read(key: 'password');
      if (password == null) return null;
      return authenticate(username: email, password: password);
    }
    if (this._userType == UserType.Instrument) {
      return readInstrumentUser(name, surname, email);
    }
    return readPosUser(name, surname, email);
  }

  Future<User> readInstrumentUser(
      String name, String surname, String email) async {
    final actorsJsonArray = await secureStorage.read(key: 'actors');
    final actorsArray = json.decode(actorsJsonArray);
    List<Actor> actors;
    if (this._userType == UserType.Instrument) {
      actors = actorsArray
          .map<Instrument>((instrument) => Instrument.fromMap(instrument))
          .toList();
    } else {
      actors = actorsArray.map<Pos>((pos) => Pos.fromMap(pos)).toList();
    }
    return User(name, surname, email, actors, []);
  }

  Future<User> readPosUser(String name, String surname, String email) async {
    final actorsJsonArray = await secureStorage.read(key: 'actors');
    final actorsArray = json.decode(actorsJsonArray);
    final merchants = List<Merchant>.from(
        actorsArray.map<Merchant>((m) => Merchant.fromMap(m)));
    return User(name, surname, email, [], merchants);
  }

  Future<String> readEmail() async {
    final mmkv = await MmkvFlutter.getInstance();
    final email = await mmkv.getString('email');
    return email;
  }

  Future<bool> hasToken() async {
//    String private = await secureStorage.read(key: User.dbPrivateKey);
    final mmkv = await MmkvFlutter.getInstance();
    final name = await mmkv.getString(User.dbName);
    final surname = await mmkv.getString(User.dbSurname);
    return name != null && surname != null;
  }
}
