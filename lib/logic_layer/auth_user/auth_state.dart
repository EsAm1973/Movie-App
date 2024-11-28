part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final DatabaseHelper databaseHelper;

  SignUpSuccess({required this.databaseHelper});
}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}
