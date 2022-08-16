import '../dao/noticias_dao.dart';
import '../models/noticia_model.dart';
import 'generic_service.dart';

class NoticiaService implements GenericService<NoticiaModel> {
  final NoticiasDao _noticiasDao;

  NoticiaService(this._noticiasDao);

  @override
  Future<bool> delete(int id) async => _noticiasDao.delete(id);

  @override
  Future<List<NoticiaModel>> findAll() async => _noticiasDao.findAll();

  @override
  Future<NoticiaModel?> findOne(int id) async => _noticiasDao.findOne(id);

  @override
  Future<bool> save(NoticiaModel value) async {
    if (value.id != null) {
      return _noticiasDao.update(value);
    } else {
      return _noticiasDao.create(value);
    }
  }
}
