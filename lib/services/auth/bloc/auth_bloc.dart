import 'package:bloc/bloc.dart';
import 'package:dairl/services/auth/auth_provider.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    // log in
    on<AuthEventLogIn>((event, emit) async {
      try {
        emit(AuthStateLoading());
        final email = event.email;
        final password = event.password;

        final user = await provider.logIn(email: email, password: password);
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });
    // log out
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await provider.logOut();
        emit(AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
    // want to log in
    on<AuthEventWantToLogIn>((event, emit) {
      emit(AuthStateWantToLogIn());
    });

    // want to register
    on<AuthEventWantToRegister>((event, emit) {
      emit(AuthStateWantToRegister());
    });

    // register
    on<AuthEventRegister>((event, emit) async {
      try {
        emit(AuthStateLoading());

        final email = event.email;
        final password = event.password;
        await provider.createUser(email: email, password: password);

        emit(AuthStateNeedsVerification());
      } on Exception catch (e) {
        emit(AuthStateRegisterFailure(e));
      }
    });
  }
}
