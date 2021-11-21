import 'package:yukon/model/user.dart';

class UserRepository {
  final User _user = User(
      id: '23434',
      name: 'vishwa',
      image: 'test',
      phoneNumber: '3453455',
      address: 'sdfdsf',
      email: 'sdfdsf',
      status: 'status');
  Future<User> getUserInformation(String token) async {
    return _user;
  }
}
