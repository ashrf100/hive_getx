import 'package:get/get.dart';
import 'package:hive_test/core/const/strings.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          Strings.settingstitle: 'User Settings',
          Strings.settingsSubtitle: 'Manage All Settings Easily',
          Strings.currency: 'Currency',
          Strings.language: 'Language',
          Strings.darkMode: 'Dark Mode',
          Strings.backupSettings: 'Backup Settings',
          Strings.exportEntries: 'Export Entries', 
          Strings.importEntries: 'Import Entries',
          Strings.trackDailyExpenses: 'Track Daily Expenses',
          Strings.manageSpendingEasily: 'Manage Spending Easily',
          Strings.recentExpenses: 'Recent Expenses',
          Strings.enterDailySpending: 'Enter your daily spending',
          Strings.noteHint: 'Write something memorable...',
          Strings.saveButtonText: 'SAVE',
          Strings.amountHint: 'example. 50 LE',
          Strings.addNote: 'Add a Note (optional)',
        },
        'ar': {
          Strings.settingstitle: 'إعدادات المستخدم',
          Strings.settingsSubtitle: 'إدارة جميع الإعدادات بسهولة',
          Strings.currency: 'العملة',
          Strings.language: 'اللغة',
          Strings.darkMode: 'الوضع الليلي',
          Strings.backupSettings: 'إعدادات النسخ الاحتياطي',
          Strings.exportEntries: 'تصدير البيانات',
          Strings.importEntries: 'استيراد البيانات',
          Strings.trackDailyExpenses: 'تتبع النفقات اليومية',
          Strings.manageSpendingEasily: 'إدارة الإنفاق بسهولة',
          Strings.recentExpenses: 'المصروفات الأخيرة',
          Strings.enterDailySpending: 'أدخل نفقاتك اليومية',
          Strings.noteHint: 'اكتب شيئًا لا يُنسى...',
          Strings.saveButtonText: 'حفظ',
          Strings.amountHint: 'مثال: 50 ج.م',
          Strings.addNote: 'إضافة ملاحظة (اختياري)',
        }
      };

  static String translate(String key) {
    return MyTranslations().keys[Get.locale!.toString()]![key]!;
  }
}
