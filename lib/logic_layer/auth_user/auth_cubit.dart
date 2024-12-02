import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/model/user.dart';
import 'package:movie_app/data/repository/auth_user_repository.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUserRepository _authUserRepository;
  final UserDataCubit _userDataCubit;
  AuthCubit(
      {required UserDataCubit userDataCubit,
      required AuthUserRepository authUserRepository})
      : _authUserRepository = authUserRepository,
        _userDataCubit = userDataCubit,
        super(AuthInitial());

  Future<void> register(String username, String password) async {
    emit(SignUpLoading());
    try {
      final userId = await _authUserRepository.registerUser(username, password);
      emit(SignUpSuccess(databaseHelper: _authUserRepository.databaseHelper));
    } catch (e) {
      emit(SignUpError('Failed to register user: $e'));
    }
  }

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final user = await _authUserRepository.loginUser(username, password);
      if (user != null) {
        _userDataCubit.setUser(user);
        print('The Id of user: ${_userDataCubit.state!.id}');
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(errMessage: 'Invalid Username or Password'));
      }
    } catch (ex) {
      emit(LoginFailure(errMessage: 'Login faild: ${ex.toString()}'));
    }
  }
}
