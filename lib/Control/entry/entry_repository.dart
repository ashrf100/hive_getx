import 'package:hive_test/core/data_source/data_source_repository.dart';
import 'package:hive_test/model/Entry/entry_model.dart';

abstract class EntryRepository {
  Future<void> addEntry(Entry entry);
  Future<Entry?> getEntry(String id);
  Future<void> updateEntry(Entry entry);
  Future<void> deleteEntry(String id);
  Future<List<Entry>> getAllEntries();
}

class HiveEntryRepository implements EntryRepository {
  final HiveRepository<Entry> hiveRepository;

  HiveEntryRepository(this.hiveRepository);

  @override
  Future<void> addEntry(Entry entry) async {
    await hiveRepository.create(entry.id, entry);
  }

  @override
  Future<Entry?> getEntry(String id) async {
    return await hiveRepository.read(id);
  }

  @override
  Future<void> updateEntry(Entry entry) async {
    await hiveRepository.update(entry.id, entry);
  }

  @override
  Future<void> deleteEntry(String id) async {
    await hiveRepository.delete(id);
  }

  @override
  Future<List<Entry>> getAllEntries() async {
    return await hiveRepository.getAll();
  }
}
