import '../dao/item_dao.dart';
import '../models/item_model.dart';
import 'generic_service.dart';

class ItemService implements GenericService<ItemModel> {
  final ItemDao _itemDao;

  ItemService(this._itemDao);
  @override
  Future<bool> delete(int id) => _itemDao.delete(id);

  @override
  Future<List<ItemModel>> findAll() => _itemDao.findAll();

  @override
  Future<ItemModel?> findOne(int id) => _itemDao.findOne(id);

  @override
  Future<bool> save(value) =>
      value.id != null ? _itemDao.update(value) : _itemDao.create(value);
}
