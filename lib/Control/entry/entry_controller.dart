import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_repository.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';

class EntryController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TextEditingController amountControllerHome = TextEditingController();
  TextEditingController noteControllerHome = TextEditingController();
  final formKeyHome = GlobalKey<FormState>();

  Rx<Category?> selectedCategory = Rx<Category?>(null);
  Rx<Category?> selectedUpdateCategory = Rx<Category?>(null);

  var categories = <Category>[].obs;
  var entries = <Entry>[].obs;

  Entry? updatedEntry;

  final EntryRepository entryRepository = Get.find<EntryRepository>();
  final CategoryRepository categoryRepository = Get.find<CategoryRepository>();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadEntries();
  }

  void loadCategories() async {
    categories.value = await categoryRepository.getAllCategories();
  }

  void loadEntries() async {
    entries.value = await entryRepository.getAllEntries();
  }

  void selectCategory(Category category, bool isHome) {
    if (isHome) {
      selectedCategory.value = category;
    } else {
      selectedUpdateCategory.value = category;
    }
  }

  Future<void> saveEntry(bool isHome) async {
    final finalAmount =
        isHome ? amountControllerHome.text : amountController.text;
    final finalNote = isHome ? noteControllerHome.text : noteController.text;
    final key = isHome ? formKeyHome : formKey;

    if (key.currentState!.validate()) {
      final selectedCategoryValue = isHome
          ? selectedCategory.value
          : selectedUpdateCategory.value ?? updatedEntry?.category;

      if (selectedCategoryValue != null) {
        Entry entry = Entry(
          id: isHome ? UniqueKey().toString() : updatedEntry!.id,
          amount: double.parse(finalAmount),
          category: selectedCategoryValue,
          date: isHome ? DateTime.now() : updatedEntry!.date,
          note: finalNote.isNotEmpty ? finalNote : null,
        );

        if (isHome) {
          await entryRepository.addEntry(entry);
        } else {
          await entryRepository.updateEntry(entry);
        }

        clearControllers();
        loadEntries();
        Get.back();
        showSnackbar('Entry saved successfully', Colors.green);
      } else {
        showSnackbar('Please choose a category', Colors.red);
      }
    }
  }

  void updateEntry(Entry entry) {
    amountController.text = entry.amount.toString();
    noteController.text = entry.note ?? "";
    selectedUpdateCategory.value = entry.category;
    updatedEntry = entry;
  }

  Future<void> deleteEntry(Entry entry) async {
    await entryRepository.deleteEntry(entry.id);
    loadEntries();
    showSnackbar('Entry deleted successfully', Colors.green);
  }

  void clearControllers() {
    amountController.clear();
    noteController.clear();
    amountControllerHome.clear();
    noteControllerHome.clear();
    selectedUpdateCategory.value = null;
    selectedCategory.value = null;
  }

  String? validateCategory(Category? value) {
    if (value == null && selectedUpdateCategory.value == null) {
      return 'Please select a category';
    }
    return null;
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    return null;
  }

  void showSnackbar(String message, Color color) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
  }
}
