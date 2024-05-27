import 'package:get/get.dart';

import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';

import 'package:hive_test/Control/entry/entry_repository.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/core/data_source/data_source_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EntryRepository>(
      HiveEntryRepository(HiveRepository<Entry>(entryBox)),
    );
    Get.put<CategoryRepository>(
      HiveCategoryRepository(HiveRepository<Category>(categoriesBox)),
    );

    Get.put<EntryController>(EntryController());
  }
}
