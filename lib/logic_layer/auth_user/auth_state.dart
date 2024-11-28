part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignUpValid extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final DatabaseHelper databaseHelper;

  SignUpSuccess({required this.databaseHelper});
}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}
