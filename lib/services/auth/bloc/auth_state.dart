import 'package:dairl/services/auth/auth_user.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateLoginFailure extends AuthState {
  final Exception exception;

  const AuthStateLoginFailure(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;

  const AuthStateLogoutFailure(this.exception);
}

class AuthStateRegistered extends AuthState {
  const AuthStateRegistered();
}

class AuthStateRegisterFailure extends AuthState {
  final Exception exception;
  const AuthStateRegisterFailure(this.exception);
}

class AuthStateWantToRegister extends AuthState {
  const AuthStateWantToRegister();
}

class AuthStateWantToLogIn extends AuthState {
  const AuthStateWantToLogIn();
}
