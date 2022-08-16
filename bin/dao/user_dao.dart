import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDao implements Dao<UserModel> {
  final DBConfiguration _dbConfiguration;

  UserDao(this._dbConfiguration);

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _execQuery('SELECT * FROM usuarios');
    return result
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _execQuery('SELECT * FROM usuarios where id = ?', [id]);
    return result.affectedRows == 0
        ? null
        : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> create(UserModel value) async {
    var result = await _execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?);',
      [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _execQuery(
      'UPDATE usuarios set nome = ?, password = ? where id = ?;',
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _execQuery('DELETE FROM usuarios WHERE id = ?;', [id]);
    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var result =
        await _execQuery('SELECT * FROM usuarios where email = ?', [email]);

    return result.affectedRows == 0
        ? null
        : UserModel.fromEmail(result.first.fields);
  }

  _execQuery(String sql, [List? params]) async {
    var connection = await _dbConfiguration.connection;
    return await connection.query(sql, params);
  }
}
