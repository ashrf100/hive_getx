import 'package:hive/hive.dart';

abstract class Repository<T> {
  Future<void> create(String key, T item);
  Future<T?> read(String key);
  Future<void> update(String key, T item);
  Future<void> delete(String key);
  Future<List<T>> getAll();
}

class HiveRepository<T> implements Repository<T> {
  final String boxName;

  HiveRepository(this.boxName);

  Future<Box<T>> _openBox() async {
    return await Hive.openBox<T>(boxName);
  }

  @override
  Future<void> create(String key, T item) async {
    final box = await _openBox();
    await box.put(key, item);
  }

  @override
  Future<T?> read(String key) async {
    final box = await _openBox();
    return box.get(key);
  }

  @override
  Future<void> update(String key, T item) async {
    final box = await _openBox();
    await box.put(key, item);
  }

  @override
  Future<void> delete(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  @override
  Future<List<T>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }
}
