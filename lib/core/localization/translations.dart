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
          Strings.noEntriesAddedYet: 'No entries added yet',
          Strings.entrySavedSuccess: 'Entry saved successfully',
          Strings.chooseCategoryError: 'Please choose a category',
          Strings.deleteEntryTitle: 'Delete Entry',
          Strings.deleteEntryContent:
              'Are you sure you want to delete this entry?',
          Strings.entryDeletedSuccess: 'Entry deleted successfully',
          Strings.enterAmountError: 'Please enter the amount',
          Strings.dataImportedSuccess: 'Data imported successfully',
          Strings.addNewCategory: 'Add New Category',
          Strings.addCategorySubtitle: 'You can add up to 10 categories.',
          Strings.yourCategories: 'Your Categories',
          Strings.manageCategoriesSubtitle:
              'Manage your existing categories below.',
          Strings.noCategoriesAdded: 'You haven\'t added any categories yet.',
          Strings.categoryName: 'Category Name',
          Strings.enterCategoryName: 'Enter a category name',
          Strings.addCategory: 'Add Category',
          Strings.selectIcon: 'Select Icon',
          Strings.pleaseSelectIcon: 'Please select an icon',
          Strings.maxCategoriesReached: 'You can add up to 10 categories.',
          Strings.categoryAddedSuccess:
              '{categoryName} added to categories successfully',
          Strings.categoryNameTooLong:
              'Category name cannot exceed 10 characters',
          Strings.spendingJourneyTitle: 'Where Does Your Money Go?',
          Strings.spendingJourneySubtitle:
              'Explore your spending journey (Swipe left & right)',
          Strings.previous: 'Previous',
          Strings.next: 'Next',
          Strings.page: 'Page',
          Strings.paintYourSpendingPicture: 'Paint Your Spending Picture',
          Strings.filterExploreTransactions:
              'Filter & explore transactions with ease',
          Strings.keywordInNotes: 'Keyword in Notes',
          Strings.fromDate: 'From Date',
          Strings.toDate: 'To Date',
          Strings.selectCategory: 'Select Category',
          Strings.none: 'None',
          Strings.filter: 'Filter',
          // New translation
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
          Strings.noEntriesAddedYet: 'لم تتم إضافة أي إدخالات حتى الآن',
          Strings.entrySavedSuccess: 'تم حفظ الإدخال بنجاح',
          Strings.chooseCategoryError: 'الرجاء اختيار فئة',
          Strings.deleteEntryTitle: 'حذف الإدخال',
          Strings.deleteEntryContent:
              'هل أنت متأكد من رغبتك في حذف هذا الإدخال؟',
          Strings.entryDeletedSuccess: 'تم حذف الإدخال بنجاح',
          Strings.enterAmountError: 'الرجاء إدخال المبلغ',
          Strings.dataImportedSuccess: 'تم استيراد البيانات بنجاح',
          Strings.addNewCategory: 'إضافة فئة جديدة',
          Strings.addCategorySubtitle: 'يمكنك إضافة ما يصل إلى 10 فئات.',
          Strings.yourCategories: 'فئاتك',
          Strings.manageCategoriesSubtitle: 'إدارة فئاتك الموجودة أدناه.',
          Strings.noCategoriesAdded: 'لم تقم بإضافة أي فئات حتى الآن.',
          Strings.categoryName: 'اسم الفئة',
          Strings.enterCategoryName: 'أدخل اسم الفئة',
          Strings.addCategory: 'أضف الفئة',
          Strings.selectIcon: 'اختر رمز',
          Strings.pleaseSelectIcon: 'يرجى اختيار رمز',
          Strings.maxCategoriesReached: 'يمكنك إضافة ما يصل إلى 10 فئات.',
          Strings.categoryAddedSuccess:
              'تمت إضافة {categoryName} إلى الفئات بنجاح',
          Strings.categoryNameTooLong: 'لا يمكن أن يتجاوز اسم الفئة 10 أحرف',
          Strings.spendingJourneyTitle: 'أين تذهب أموالك؟',
          Strings.spendingJourneySubtitle:
              'استكشف رحلتك في الإنفاق (اسحب لليسار واليمين)',
          Strings.previous: 'السابق',
          Strings.next: 'التالي',
          Strings.page: 'الصفحة',
          Strings.paintYourSpendingPicture: 'ارسم صورة إنفاقك',
          Strings.filterExploreTransactions: 'تصفية واستكشاف المعاملات بسهولة ',
          Strings.keywordInNotes: 'الكلمة الرئيسية في الملاحظات',
          Strings.fromDate: 'من التاريخ',
          Strings.toDate: 'حتى الآن',
          Strings.selectCategory: 'اختر الفئة',
          Strings.none: 'لا شيء',
          Strings.filter: 'تصفية',
          // New translation
        },
      };

  static String translate(String key) {
    return MyTranslations().keys[Get.locale!.toString()]![key]!;
  }
}
