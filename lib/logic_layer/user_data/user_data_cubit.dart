import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/user.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<User?> {
  UserDataCubit() : super(null);

  void setUser(User user) => emit(user);
  void clearUser() => emit(null);
}
