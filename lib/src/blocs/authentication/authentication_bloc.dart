import 'package:meta/meta.dart';
import 'package:wom_package/src/helpers/user/user_repository.dart';
import 'package:wom_package/src/models/user.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final User user = await userRepository.readUser();

      if (user != null) {
        yield AuthenticationAuthenticated(user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
//      yield AuthenticationLoading();
      await userRepository.persistToken(event.user);
      yield AuthenticationAuthenticated(event.user);
    }

    if (event is LoggedOut) {
//      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
