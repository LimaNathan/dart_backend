abstract class Dao<T> {
///CRUD 
  Future create(T value);
  Future<T> findOne(int id);
  Future<List<T>> findAll();
  Future update(T value);
  Future<T> delete(int id);
}
