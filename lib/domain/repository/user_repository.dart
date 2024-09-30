import 'package:moi_interview/domain/model/user.dart';

abstract interface class UserRepository {
  void createUser(User user);

  User getUser();
}
