import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/domain/model/user.dart';

class UserDataSource {
  void createUser(User user) {
    Box box = Hive.box('user');
    box.put('user', user);
  }

  User? getUser() {
    User? user = Hive.box('user').get('user');
    return user;
  }

  void updateUser() {}
}
