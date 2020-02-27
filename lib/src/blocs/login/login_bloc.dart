import 'dart:async';
import 'package:bloc/bloc.dart';
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

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      user = await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );

      if (user.error != null) {
        print(user.error);
        yield LoginFailure(error: "Username e/o password non validi!");
      } else {
        authenticationBloc.dispatch(LoggedIn(user: user));
        yield LoginSuccessfull();
        print(user.name);
      }
    }
  }
}
