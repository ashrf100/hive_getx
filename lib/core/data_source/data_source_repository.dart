import 'package:hive/hive.dart';

abstract class Repository<T> {
  Future<void> create(T item, String key);
  Future<T?> read(String key);
  Future<void> update(String key, T item);
  Future<void> delete(String key);
  Future<List<T>> getAll();
  Future<void> deleteAll();
  Future<List<T>> getValuesInRange(int startIndex, int endIndex);
}

class HiveRepository<T> implements Repository<T> {
  final String boxName;

  HiveRepository(this.boxName);

  Future<Box<T>> _openBox() async {
    return await Hive.openBox<T>(boxName);
  }

  @override
  Future<void> create(T item, String key) async {
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
    final values = box.values.toList();
    return values.reversed.toList();
  }

  @override
  Future<List<T>> getValuesInRange(int startIndex, int endIndex) async {
    final box = await _openBox();

    // Get the total number of items in the box
    final int length = box.length;

    // Adjust the start index to work from the end of the list.
    final int adjustedStartIndex = (length - 1 - startIndex).clamp(0, length);

    // Adjust the end index similarly.
    final int adjustedEndIndex = (length - 1 - endIndex + 1).clamp(0, length);

    // Check if the adjusted indices are valid.
    if (adjustedEndIndex >= adjustedStartIndex) {
      return [];
    }

    // Fetch the entries in reverse order from adjustedStartIndex to adjustedEndIndex.
    final List<T> result = [];
    for (int i = adjustedStartIndex; i >= adjustedEndIndex; i--) {
      final value = box.getAt(i);
      if (value != null) {
        result.add(value);
      }
    }

    return result;
  }

  @override
  Future<void> deleteAll() async {
    final box = await _openBox();
    await box.clear();
  }
}
