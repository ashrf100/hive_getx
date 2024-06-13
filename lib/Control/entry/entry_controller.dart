import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_repository.dart';
import 'package:hive_test/Control/entry/entry_repository.dart';
import 'package:hive_test/core/services/dialog_service.dart';
import 'package:hive_test/core/services/file_service.dart';
import 'package:hive_test/core/services/message_service.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/core/const/strings.dart'; // import the Strings class

class EntryController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController amountControllerHome = TextEditingController();
  final TextEditingController noteControllerHome = TextEditingController();
  final GlobalKey<FormState> formKeyHome = GlobalKey<FormState>();

  final Rx<Category?> selectedCategory = Rx<Category?>(null);
  final Rx<Category?> selectedUpdateCategory = Rx<Category?>(null);

  final RxList<Category> categories = <Category>[].obs;
  final RxList<Entry> paginationEntries = <Entry>[].obs;
  final RxList<Entry> valuesInRange = <Entry>[].obs;

  final EntryRepository entryRepository = Get.find<EntryRepository>();
  final CategoryRepository categoryRepository = Get.find<CategoryRepository>();
  final FileService fileService = FileServiceImpl();
  final MessageService messageService = FlutterToastMessageService();
  final DialogService dialogService = FlutterDialogService();

  Entry? updatedEntry;
  final RxBool isNext = true.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 8;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadValuesInRange(0, pageSize);
  }

  void loadCategories() async {
    categories.value = await categoryRepository.getAllCategories();
  }

  Future<void> loadValuesInRange(int startIndex, int endIndex) async {
    valuesInRange.value =
        await entryRepository.getValuesInRange(startIndex, endIndex);
    loadPaginationEntries();
  }

  Future<void> loadPaginationEntries() async {
    final int startIndex = (currentPage.value - 1) * pageSize;
    final int endIndex = startIndex + pageSize;

    paginationEntries.value =
        await entryRepository.getValuesInRange(startIndex, endIndex);

    isNext.value = paginationEntries.isEmpty ? false : true;
  }

  void loadMoreEntries() {
    currentPage.value += 1;
    loadPaginationEntries();
  }

  void selectCategory(Category category, bool isHome) {
    isHome
        ? selectedCategory.value = category
        : selectedUpdateCategory.value = category;
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
        final entry = Entry(
          id: isHome ? DateTime.now().toString() : updatedEntry!.id,
          amount: double.parse(finalAmount),
          category: selectedCategoryValue,
          date: isHome ? DateTime.now() : updatedEntry!.date,
          note: finalNote.isNotEmpty ? finalNote : null,
        );

        isHome
            ? await entryRepository.addEntry(entry)
            : await entryRepository.updateEntry(entry);

        clearControllers();
        loadValuesInRange(0, pageSize);
        Get.back();
        messageService.showSuccess(Strings.entrySavedSuccess.tr);
      } else {
        messageService.showError(Strings.chooseCategoryError.tr);
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
    await dialogService.showConfirmationDialog(
      title: Strings.deleteEntryTitle.tr,
      content: Strings.deleteEntryContent.tr,
      onConfirm: () async {
        await entryRepository.deleteEntry(entry.id);
        loadValuesInRange(0, pageSize);
        messageService.showSuccess(Strings.entryDeletedSuccess.tr);
      },
    );
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
    return (value == null && selectedUpdateCategory.value == null)
        ? Strings.chooseCategoryError.tr
        : null;
  }

  String? validator(value) {
    return (value == null || value.isEmpty)
        ? Strings.enterAmountError.tr
        : null;
  }

  Future<void> exportEntries() async {
    final result = await entryRepository.exportEntries(fileService);
    result.isSuccess
        ? messageService.showSuccess(result.data!)
        : messageService.showError(result.error!);
  }

  Future<void> importEntries() async {
    final result = await entryRepository.importEntries(fileService);
    if (result.isSuccess) {
      loadValuesInRange(0, 5);
      messageService.showSuccess(Strings.dataImportedSuccess.tr);
    } else {
      messageService.showError(result.error!);
    }
  }
}
