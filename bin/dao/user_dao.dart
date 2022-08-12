import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDao implements Dao<UserModel> {
  final DBConfiguration _dbConfiguration;

  UserDao(this._dbConfiguration);

  @override
  Future<List<UserModel>> findAll() async {
    final String sql = 'SELECT * FROM usuarios';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(sql);
    List<UserModel> users = [];
    for (var r in result) {
      users.add(UserModel.fromMap(r.fields));
    }

    return users;
  }

  @override
  Future<UserModel> findOne(int id) async {
    final String sql = 'SELECT * FROM usuarios where id = ?';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(sql, [id]);
    if (result.length <= 0) {
      throw Exception('[ERROR/DB] -> findOne $id, not Found');
    }
    return UserModel.fromMap(result.first.fields);
  }

  @override
  Future create(UserModel value) async {
    final String sql =
        'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?);';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(
      sql,
      [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future update(UserModel value) async {
    final String sql =
        'UPDATE usuarios set nome = ?, password = ? where id = ?;';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(
      sql,
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<UserModel> delete(int id) async {
    final String sql = 'DELETE FROM usuarios WHERE id = ?;';
    var connection = await _dbConfiguration.connection;
    var result = await connection.query(sql, [id]);
    return result.affectedRows > 0;
  }
}
