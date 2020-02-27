import 'dart:convert';
import 'package:wom_package/src/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';

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
      return User.fromMap(map[type].first);
    } catch (ex) {
      return User(error: ex.toString());
    }
  }

  Future<void> deleteToken() async {
    final mmkv = await MmkvFlutter.getInstance();
    mmkv.clear();
//    await secureStorage.delete(key: User.dbPublicKey);
    await secureStorage.delete(key: User.dbPrivateKey);
  }

  Future<void> persistToken(User user) async {
    final mmkv = await MmkvFlutter.getInstance();
    mmkv.setString(User.dbName, user.name);
    mmkv.setString(User.dbId, user.id);
    mmkv.setString(User.dbUrl, user.url);
//    await secureStorage.write(key: User.dbPublicKey, value: user.publicKey);
    await secureStorage.write(key: User.dbPrivateKey, value: user.privateKey);
  }

  Future<User> readUser() async {
    final mmkv = await MmkvFlutter.getInstance();
    final name = await mmkv.getString(User.dbName);
    final id = await mmkv.getString(User.dbId);
    final url = await mmkv.getString(User.dbUrl);
//    final public = await secureStorage.read(key: User.dbPublicKey);
    //TODO cambia con privateKey quando si ha anche la private key nel response
    final private = await secureStorage.read(key: User.dbPrivateKey);
    return User(name: name, id: id, privateKey: private, url: url);
  }

  Future<bool> hasToken() async {
//    String public = await secureStorage.read(key: User.dbPublicKey);
    String private = await secureStorage.read(key: User.dbPrivateKey);
    return private != null;
  }
}
