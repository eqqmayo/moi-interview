import 'package:moi_interview/data/data_source/user_data_source.dart';
import 'package:moi_interview/domain/model/user.dart';
import 'package:moi_interview/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  void createUser(User user) {
    _userDataSource.createUser(user);
  }
}
