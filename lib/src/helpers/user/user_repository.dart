import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:wom_package/src/models/user.dart';

import '../http_helper.dart';

class UserRepository {
  final UserType _userType;

  UserRepository(this._userType);

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    try {
      final bytes = utf8.encode('$username:$password');
      final base64String = Base64Encoder().convert(bytes);
      final body = await HttpHelper.authenticate(base64String);
      final map = json.decode(body);
      final type = this._userType == UserType.Instrument ? 'sources' : 'pos';
      return User.fromMap(map[type].first);
    } catch (ex) {
      return User(error: ex.toString());
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
