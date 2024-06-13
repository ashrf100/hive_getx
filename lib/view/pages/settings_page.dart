import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:country_icons/country_icons.dart';
import 'package:hive_test/Control/settings/app_services.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/view/pages/backup_page.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

class SettingsPage extends GetView<AppServices> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSubtitleWidget(
                    title: Strings.settingstitle.tr,
                    subtitle: Strings.settingsSubtitle.tr,
                  ),
                  const SizedBox(height: 24),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          buildDropdownTile(
                            title: Strings.currency.tr,
                            value: controller.userSettings.value.currency,
                            items: [
                              'EGP',
                              'USD',
                              'EUR',
                              'JPY',
                              'GBP',
                              'AUD',
                              'SAR',
                              'AED',
                              'QAR',
                              'KWD'
                            ],
                            onChanged: (p0) {
                              controller.updateCurrency(p0!);
                            },
                          ),
                          buildDropdownTile(
                            title: Strings.language.tr,
                            value: controller.userSettings.value.language,
                            items: ['en', 'ar'],
                            onChanged: (newValue) {
                              if (newValue != null) {
                                controller.updateLanguage(newValue);
                              }
                            },
                          ),
                          buildSwitchTile(
                            title: Strings.darkMode.tr,
                            value: controller.userSettings.value.isDarkMode,
                            onChanged: (newValue) =>
                                controller.toggleThemeMode(),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.to(const BackupScreen());
                              },
                              child: Text(Strings.backupSettings.tr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownTile({
    required String title,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          DropdownButtonFormField2(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: buildDropdownItem(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownItem(String value) {
    String flagCode = getFlagCode(value);

    return Row(
      children: [
        SizedBox(
            width: 24, height: 24, child: CountryIcons.getSvgFlag(flagCode)),
        const SizedBox(width: 8),
        Text(value.toUpperCase()),
      ],
    );
  }

  String getFlagCode(String value) {
    switch (value) {
      case 'USD':
        return 'us';
      case 'EUR':
        return 'eu';
      case 'JPY':
        return 'jp';
      case 'GBP':
        return 'gb';
      case 'AUD':
        return 'au';
      case 'EGP':
        return 'eg';
      case 'SAR':
        return 'sa';
      case 'AED':
        return 'ae';
      case 'QAR':
        return 'qa';
      case 'KWD':
        return 'kw';
      case 'en':
        return 'us';
      case 'ar':
        return 'ae';
      default:
        return 'us';
    }
  }

  Widget buildSwitchTile({
    required String title,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SwitchListTile(
        title: Text(title),
        inactiveTrackColor: Colors.grey,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
