import 'package:wom_package/src/models/user.dart';
import 'package:wom_package/src/models/user_type.dart';

class UserRepository {
  final UserType _userType;

  UserRepository(this._userType);

  Future<User> authenticate({
    String username,
    String password,
  }) async {
    try {
      return User('name', 'surname', [], []);
    } catch (ex) {
      throw ex;
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
    return User('name', 'surname', [], []);
  }

  Future<bool> hasToken() async {
    print("hasToken_web");
    return true;
  }
}
