import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';

class EntryController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  Rx<Category?> selectedCategory = Rx<Category?>(null);
  var categories = <Category>[].obs;
  var entries = <Entry>[].obs;
  final formKey = GlobalKey<FormState>();
  final formKeyHome = GlobalKey<FormState>();

  final categorieBox = Hive.box<Category>(categoriesBox);
  final entriesBox = Hive.box<Entry>(entryBox);

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadEntries();
  }

  void loadCategories() {
    categories.value = categorieBox.values.toList();
  }

  void loadEntries() {
    entries.value = entriesBox.values.toList();
    print(entriesBox.values);
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
  }

  void saveEntry() {
    if (amountController.text.isEmpty || selectedCategory.value == null) {
      return;
    }

    Entry entry = Entry(
      id: UniqueKey().toString(),
      amount: double.parse(amountController.text),
      category: selectedCategory.value!,
      date: DateTime.now(),
      note: noteController.text.isNotEmpty ? noteController.text : null,
    );
    entriesBox.add(entry);
    loadEntries();

    amountController.clear();
    noteController.clear();
    selectedCategory.value = null;

    Get.showSnackbar(const GetSnackBar(
      isDismissible: true,
      duration: Duration(seconds: 2),
      message: "Entry added successfully",
      backgroundColor: Colors.green,
    ));
  }

  void deleteEntry(Entry entry) {
    final entryKey = entriesBox.keys.firstWhere(
      (key) => entriesBox.get(key) == entry,
      orElse: () => null,
    );

    if (entryKey != null) {
      entriesBox.delete(entryKey);
      loadEntries();
    }
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    return null;
  }
}
