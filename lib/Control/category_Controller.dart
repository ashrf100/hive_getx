import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Control/entry_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive/hive.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  final box = Hive.box<Category>('categories');
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() {
    categories.value = box.values.toList();
    var controller = Get.put(EntryController());
    controller.categories = categories;
  }

  void addCategory(Category category) {
    box.add(category);
    loadCategories();
  }

  void deleteCategory(String id) {
    final categoryToDelete =
        categories.firstWhere((category) => category.id == id);
    final key = box.keys.firstWhere((key) => box.get(key) == categoryToDelete);
    box.delete(key);
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
