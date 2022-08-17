import '../infra/database/db_configuration.dart';
import '../models/item_model.dart';
import 'dao.dart';

class ItemDao extends Dao<ItemModel> {
  final DBConfiguration _dbConfiguration;

  ItemDao(this._dbConfiguration);
  @override
  Future<bool> create(ItemModel value) async {
    var result = await _dbConfiguration.execQuery(
        'insert into itens (title, is_active) values (?,?)',
        [value.title, value.isActive! ? 1 : 0]);

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE FROM itens WHERE id = ?;', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<ItemModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM itens');
    return result
        .map((r) => ItemModel.fromMap(r.fields))
        .toList()
        .cast<ItemModel>();
  }

  @override
  Future<ItemModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM itens where id = ?', [id]);
    return result.isEmpty ? null : ItemModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(ItemModel value)async {
    var result = await _dbConfiguration.execQuery(
      'update itens set title = ?, is_active = ? where id = ?',
      [value.title, value.isActive! ? 1 : 0, value.id],
    );
    return result.affectedRows > 0;
  }
}
