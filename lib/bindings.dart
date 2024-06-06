import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_controller.dart';
import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/Control/entry/entry_filter_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/Control/entry/entry_repository.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/core/data_source/data_source_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut<EntryRepository>(
        () => HiveEntryRepository(HiveRepository<Entry>(entryBox)));
    //
    Get.lazyPut<CategoryRepository>(
        () => HiveCategoryRepository(HiveRepository<Category>(categoriesBox)));
    //
    // controller
    Get.lazyPut<EntryController>(() => EntryController(), fenix: true);
    Get.lazyPut<EntryFilterController>(() => EntryFilterController(),
        fenix: true);
    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
  }
}
