import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/repository/auth_user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUserRepository _authUserRepository;

  AuthCubit({required AuthUserRepository authUserRepository})
      : _authUserRepository = authUserRepository,
        super(AuthInitial());

  void validateInputs(
      String username, String password, String confirmPassword) {
    if (username.isEmpty) {
      emit(SignUpError('Username cannot be empty'));
    } else if (password.isEmpty) {
      emit(SignUpError('Password cannot be empty'));
    } else if (password != confirmPassword) {
      emit(SignUpError('Passwords do not match'));
    } else {
      emit(SignUpValid());
    }
  }

  Future<void> registerUser(String username, String password) async {
    emit(SignUpLoading());
    try {
      final userId = await _authUserRepository.registerUser(username, password);
      emit(SignUpSuccess(databaseHelper: _authUserRepository.databaseHelper));
    } catch (e) {
      emit(SignUpError('Failed to register user: $e'));
    }
  }
}
