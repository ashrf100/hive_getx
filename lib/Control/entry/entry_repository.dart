import 'package:hive_test/core/data_source/data_source_repository.dart';
import 'package:hive_test/core/services/file_service.dart';
import 'package:hive_test/model/Entry/entry_model.dart';

abstract class EntryRepository {
  Future<void> addEntry(Entry entry);
  Future<Entry?> getEntry(String id);
  Future<void> updateEntry(Entry entry);
  Future<void> deleteEntry(String id);
  Future<List<Entry>> getAllEntries();
  Future<List<Entry>> getValuesInRange(int startIndex, int endIndex);

  Future<Result> exportEntries(FileService fileService);
  Future<Result> importEntries(FileService fileService);
}

class HiveEntryRepository implements EntryRepository {
  final HiveRepository<Entry> hiveRepository;

  HiveEntryRepository(this.hiveRepository);

  @override
  Future<void> addEntry(Entry entry) async {
    await hiveRepository.create(entry, entry.id);
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

  @override
  Future<List<Entry>> getValuesInRange(int startIndex, int endIndex) async {
    return await hiveRepository.getValuesInRange(startIndex, endIndex);
  }

  @override
  Future<Result> exportEntries(FileService fileService) async {
    final entries = await getAllEntries();
    final data = entries.map((entry) => entry.toJson()).toList();
    return await fileService.exportData(data, 'entries_backup.json');
  }

  @override
  Future<Result> importEntries(FileService fileService) async {
    final result = await fileService.importData('entries_backup.json');
    if (result.isSuccess) {
      final List<Map<String, dynamic>> data = result.data!;
      for (var entryData in data) {
        Entry entry = Entry.fromJson(entryData);
        await hiveRepository.create(entry, entry.id);
      }
    }
    return result;
  }
}
