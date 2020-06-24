import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wom_package/src/blocs/authentication/bloc.dart';
import 'package:wom_package/src/helpers/user/user_repository.dart';
import 'package:wom_package/src/models/user.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  User user;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null) {
    userRepository.readEmail().then((value) {
      usernameController.text = value ?? '';
    });
  }

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        user = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        print(user.name);
        authenticationBloc.add(LoggedIn(user: user, email: event.username));
        yield LoginSuccessfull();
      } catch (ex) {
        print(ex);
        yield LoginFailure(error: "Username e/o password non validi!");
      }
    }
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
