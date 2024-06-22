import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/model/Category/category_model.dart';

class CategoryController extends GetxController {
  final CategoryRepository categoryRepository = Get.find<CategoryRepository>();
  final EntryController entryController = Get.find<EntryController>();

  var categories = <Category>[].obs;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final selectedIconId = Rx<int?>(null); // Change to Rx<int?>

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    categories.value = await categoryRepository.getAllCategories();
  }

  void addCategory(Category category) async {
    await categoryRepository.addCategory(category);
    loadCategories();
    entryController.loadCategories();
  }

  void deleteCategory(String id) async {
    await categoryRepository.deleteCategory(id);
    loadCategories();
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return Strings.enterCategoryName.tr;
    } else if (value.length > 10) {
      return Strings.categoryNameTooLong.tr;
    }
    return null;
  }

  String? iconValidator() {
    if (selectedIconId.value == null) {
      return Strings.pleaseSelectIcon.tr;
    }
    return null;
  }

  void addCategoryButton() {
    print(nameController.text);
    print(selectedIconId.value);

    if (formKey.currentState!.validate() && iconValidator() == null) {
      if (categories.length < 10) {
        final id = generateId();
        final category = Category(
          id: id,
          name: nameController.text,
          iconId: selectedIconId.value!,
        );
        addCategory(category);
        nameController.clear();
        selectedIconId.value = null;

        Get.showSnackbar(GetSnackBar(
          isDismissible: true,
          duration: const Duration(seconds: 2),
          message: Strings.categoryAddedSuccess
              .trParams({'categoryName': category.name}),
          backgroundColor: Colors.green,
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          isDismissible: true,
          duration: const Duration(seconds: 2),
          message: Strings.maxCategoriesReached.tr,
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
