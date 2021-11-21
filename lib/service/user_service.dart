import 'package:yukon/model/user.dart';
import 'package:yukon/repository/user_repository.dart';

class UserService {
  final userRepository = UserRepository();

  Future<User?> validateToken(String token) async {
    bool _valid = true;
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _valid = false;
    });
    if (_valid) {
      return userRepository.getUserInformation(token);
    } else {
      return null;
    }
  }

  Future<User> getUser(String token) async {
    return await userRepository.getUserInformation(token);
  }

  Future<bool> getToken(String email, String password) async {
    // return await userRepository.getUserInformation(token);
    return true;
  }

  Future<User>? login(String email, String password) {
    if (email.compareTo('test@test.com') == 0 &&
        password.compareTo('test') == 0) {
      //this is just for testing purpose
      return userRepository.getUserInformation('123');
    } else {
      return null;
    }
  }
}
