import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/model/user.dart';

class AuthUserRepository {
  final DatabaseHelper databaseHelper;

  AuthUserRepository({required DatabaseHelper databaseHelper})
      : databaseHelper = databaseHelper;

  Future<int> registerUser(String username, String password) async {
    try {
      return await databaseHelper.registerUser(username, password);
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<User?> loginUser(String username, String password) async {
    try {
      final userMap = await databaseHelper.loginUser(username, password);
      if (userMap != null) {
        return User.fromMap(userMap);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }
}
