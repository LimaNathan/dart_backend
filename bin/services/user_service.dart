import 'package:password_dart/password_dart.dart';

import '../dao/user_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserDao _userDao;

  UserService(this._userDao);

  @override
  Future<bool> delete(int id) async => _userDao.delete(id);

  @override
  Future<List<UserModel>> findAll() async => _userDao.findAll();

  @override
  Future<bool> save(UserModel value) async {
    if ((value.id != null)) {
      return _userDao.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;
      return _userDao.create(value);
    }
  }

  @override
  Future<UserModel?> findOne(int id) async => _userDao.findOne(id);
}
