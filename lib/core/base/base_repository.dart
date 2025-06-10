abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<void> create(T item);
  Future<void> update(T item);
  Future<void> delete(int id);
}
