import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 0)
class UserSettings extends HiveObject {
  @HiveField(0)
  String currency;

  @HiveField(1)
  String language;

  @HiveField(2)
  bool isDarkMode;

  UserSettings({required this.currency, required this.language, required this.isDarkMode});
}
