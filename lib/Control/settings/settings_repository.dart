import 'package:hive_test/core/const.dart';
import 'package:hive_test/core/data_source/data_source_repository.dart';
import 'package:hive_test/model/settings/user_settings.dart';

abstract class SettingsRepository {
  Future<UserSettings?> getSettings();
  Future<void> saveSettings(UserSettings settings);
}

class HiveSettingsRepository implements SettingsRepository {
  final HiveRepository<UserSettings> hiveRepository;

  HiveSettingsRepository(this.hiveRepository);

  @override
  Future<UserSettings?> getSettings() async {
    return await hiveRepository.read(settingsBox);
  }

  @override
  Future<void> saveSettings(UserSettings settings) async {
    await hiveRepository.create(settings, settingsBox);
  }
}
