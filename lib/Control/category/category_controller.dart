import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';

class CategoryController extends GetxController {
  final CategoryRepository categoryRepository = Get.find<CategoryRepository>();
  final EntryController entryController = Get.find<EntryController>();

  var categories = <Category>[].obs;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

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
      return 'Please enter a category name';
    }
    return null;
  }

  void addCategoryButton() {
    if (formKey.currentState!.validate()) {
      if (categories.length < 10) {
        final id = generateId();
        final category = Category(
          id: id,
          name: nameController.text,
        );
        addCategory(category);
        nameController.clear();
      } else {
        Get.showSnackbar(const GetSnackBar(
          isDismissible: true,
          duration: Duration(seconds: 2),
          message: "You can add up to 10 categories.",
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
