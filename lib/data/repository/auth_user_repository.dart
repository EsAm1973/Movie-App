import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/model/user.dart';

class AuthUserRepository {
  final DatabaseHelper _databaseHelper;

  AuthUserRepository({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  Future<int> registerUser(String username, String password) async {
    try {
      return await _databaseHelper.registerUser(username, password);
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<User?> loginUser(String username, String password) async {
    try {
      final userMap = await _databaseHelper.loginUser(username, password);
      if (userMap != null) {
        return User.fromMap(userMap);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}
