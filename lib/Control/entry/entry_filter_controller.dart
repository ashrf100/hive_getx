import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/Control/entry/entry_repository.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:intl/intl.dart';

class EntryFilterController extends GetxController {
  final EntryRepository entryRepository = Get.find<EntryRepository>();

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final Rx<Category?> selectedCategory = Rx<Category?>(null);
  final RxList<Category> categories = <Category>[].obs;
  var filteredEntries = <Category, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    final entries = await entryRepository.getAllEntries();
    final Set<Category> categorySet = {};

    for (Entry entry in entries) {
      categorySet.add(entry.category);
    }

    categories.value = categorySet.toList();
  }

  void filterEntries() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      // Get filter parameters from controllers
      final fromDate = fromDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(fromDateController.text)
          : null;
      final toDate = toDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(toDateController.text)
          : null;
      final keyword =
          keywordController.text.isEmpty ? null : keywordController.text;

      filterEntriesWithParameters(fromDate, toDate, keyword);
    }
  }

  void filterEntriesWithParameters(
      DateTime? fromDate, DateTime? toDate, String? keyword) async {
    final entries = await entryRepository.getAllEntries();
    final Map<Category, double> totalsByCategory = {};

    for (var entry in entries) {
      final matchesDateRange = (fromDate == null ||
              entry.date.isAfter(fromDate.subtract(Duration(days: 1)))) &&
          (toDate == null ||
              entry.date.isBefore(toDate.add(Duration(days: 1))));
      final matchesKeyword = keyword == null ||
          (entry.note != null && entry.note!.contains(keyword));
      final matchesCategory = selectedCategory.value == null ||
          entry.category!.id == selectedCategory.value!.id;

      if (matchesDateRange && matchesKeyword && matchesCategory) {
        if (totalsByCategory.containsKey(entry.category)) {
          totalsByCategory[entry.category] =
              totalsByCategory[entry.category]! + entry.amount;
        } else {
          totalsByCategory[entry.category] = entry.amount;
        }
      }
    }

    filteredEntries.value = totalsByCategory;
  }
}
