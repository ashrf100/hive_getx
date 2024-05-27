import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';

class CategoryFieldWidget extends StatelessWidget {
  const CategoryFieldWidget(
      {super.key, required this.entryController, required this.isHome});
  final bool isHome;
  final EntryController entryController;

  @override
  Widget build(BuildContext context) {
    return FormField<Category>(
      validator: (value) => entryController.validateCategory(value),
      builder: (FormFieldState<Category> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: entryController.categories.map((category) {
                  final selectedCategory = isHome
                      ? entryController.selectedCategory.value
                      : entryController.selectedUpdateCategory.value ??
                          entryController.updatedEntry?.category;
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: selectedCategory?.id == category.id,
                    onSelected: (bool selected) {
                      if (selected) {
                        state.didChange(category);
                        entryController.selectCategory(category, isHome);
                      }
                    },
                    selectedColor: Colors.deepPurple.withOpacity(0.5),
                  );
                }).toList(),
              );
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(Get.context!).errorColor),
                ),
              ),
          ],
        );
      },
    );
  }
}
