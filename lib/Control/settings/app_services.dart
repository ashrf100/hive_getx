import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Control/settings/settings_repository.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/core/data_source/data_source_repository.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/model/settings/user_settings.dart';
import 'package:hive_test/themedata.dart';



class AppServices extends GetxService {
  final SettingsRepository _settingsRepository =
      HiveSettingsRepository(HiveRepository(settingsBox));

  Rx<UserSettings> userSettings = UserSettings(
    currency: 'USD',
    language: 'en',
    isDarkMode: false,
  ).obs;

  Future<AppServices> init() async {
    await Hive.initFlutter();
    await _initializeAdapters();
    await _loadSettings();

    return this;
  }

  Future<void> _initializeAdapters() async {
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(EntryAdapter());
    Hive.registerAdapter(UserSettingsAdapter());
  }

  Future<void> _loadSettings() async {
    UserSettings? settings = await _settingsRepository.getSettings();
    if (settings != null) {
      userSettings.value = settings;
    }
  }

  Future<void> saveSettings() async {
    await _settingsRepository.saveSettings(userSettings.value);
  }

  void updateLanguage(String language) {
    userSettings.update((settings) {
      settings?.language = language;
    });
    saveSettings();
    Get.updateLocale(Locale(language));
  }

  void toggleThemeMode() {
    userSettings.update((settings) {
      settings?.isDarkMode = !settings.isDarkMode;
    });
    saveSettings();
    Get.changeTheme(userSettings.value.isDarkMode
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);
  }

  void updateCurrency(String currency) {
    userSettings.update((settings) {
      settings?.currency = currency;
    });
    saveSettings();
  }
}

Future<void> initializeAppServices() async {
  await Get.putAsync(() => AppServices().init());
}
