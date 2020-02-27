import 'package:wom_package/src/models/user.dart';

class UserRepository {
  final UserType _userType;

  UserRepository(this._userType);

  Future<User> authenticate({
    String username,
    String password,
  }) async {
    try {
      return User(
          name: 'prova_web',
          id: "1",
          privateKey: 'private_key_web',
          url: 'url_web');
    } catch (ex) {
      return User(error: ex.toString());
    }
  }

  Future<void> deleteToken() async {
    print("deleteToken_web");
  }

  Future<void> persistToken(User user) async {
    print("persistToken_web");
  }

  Future<User> readUser() async {
    print("readUser_web");
    return User(
        name: 'prova_web',
        id: "1",
        privateKey: 'private_key_web',
        url: 'url_web');
  }

  Future<bool> hasToken() async {
    print("hasToken_web");
    return true;
  }
}
