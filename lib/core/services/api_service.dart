import 'package:pingna/core/models/user.dart';

class PingnaApi {

  Future<User> login(String email, String password) {
    return Future.value(User(1, email: email));
  }
}