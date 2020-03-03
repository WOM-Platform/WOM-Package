import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wom_package/src/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
//  final String publicKey;
//  final String privateKey;
  final User user;
  final String email;

  LoggedIn({
    @required this.user,
    @required this.email,
  }) : super([user]);

  @override
  String toString() => 'LoggedIn { name : ${user.name} }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
