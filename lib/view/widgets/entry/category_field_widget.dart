import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/services/icon_picker.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/view/pages/bottom_nav_bar.dart';
import 'package:hive_test/view/pages/categories_page.dart';

class CategoryFieldWidget extends StatelessWidget {
  const CategoryFieldWidget({
    Key? key,
    required this.entryController,
    required this.isHome,
  }) : super(key: key);

  final bool isHome;
  final EntryController entryController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedCategory = isHome
          ? entryController.selectedCategory.value
          : entryController.selectedUpdateCategory.value ??
              entryController.updatedEntry?.category;

      final categories = entryController.categories.toList();

      return FormBuilderDropdown<Category>(
        name: 'category',
        decoration: const InputDecoration(labelText: 'Select Category'),
        validator: (value) {
          if (value == null) {
            return 'Please select a category';
          }
          return null;
        },
        initialValue:
            selectedCategory != null && categories.contains(selectedCategory)
                ? selectedCategory
                : null,
        items: [
          ...categories.map((category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Row(
                children: [
                  const Icon(
                    Icons.category,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 8),
                  Text(category.name),
                ],
              ),
            );
          }).toList(),
          const DropdownMenuItem<Category>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 8),
                Text('Add New Category'),
              ],
            ),
          ),
        ],
        onChanged: (Category? newValue) {
          if (newValue == null) {
            Get.to(() => CategoryPage());
          } else {
            entryController.selectCategory(newValue, isHome);
          }
        },
      );
    });
  }
}

class CategoryChipsWidget extends StatelessWidget {
  const CategoryChipsWidget({
    Key? key,
    required this.entryController,
    required this.isHome,
  }) : super(key: key);

  final bool isHome;
  final EntryController entryController;

  @override
  Widget build(BuildContext context) {
    return FormField<Category>(
      validator: (value) => entryController.validateCategory(value),
      builder: (FormFieldState<Category> state) {
        return Column(
          children: [
            Obx(() {
              return Wrap(
                spacing: 4.0,
                runSpacing: 0,
                children: [
                  ...entryController.categories.map((category) {
                    final selectedCategory = isHome
                        ? entryController.selectedCategory.value
                        : entryController.selectedUpdateCategory.value ??
                            entryController.updatedEntry?.category;

                    return ChoiceChip(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.deepPurple,
                        width: 1,
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.zero,
                      showCheckmark: false,
                      label: Container(
                        width: 61,
                        height: 40,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                IconPicker.getIconById(category.iconId),
                                color: Colors.deepPurple,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      selected: selectedCategory?.id == category.id,
                      onSelected: (bool selected) {
                        if (selected) {
                          state.didChange(category);
                          entryController.selectCategory(category, isHome);
                        }
                      },
                      selectedColor: Colors.deepPurple,
                    );
                  }).toList(),
                  ChoiceChip(
                    padding: const EdgeInsets.all(8),
                    label: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                    selected: false,
                    onSelected: (bool selected) {
                      if (selected) {}
                    },
                    backgroundColor: Colors.deepPurple,
                    selectedColor: Colors.grey.shade400,
                  ),
                ],
              );
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
    Key? key,
    required this.entryController,
    required this.isHome,
  }) : super(key: key);

  final bool isHome;
  final EntryController entryController;

  @override
  Widget build(BuildContext context) {
    return FormField<Category>(
      validator: (value) => entryController.validateCategory(value),
      builder: (FormFieldState<Category> state) {
        return Column(
          children: [
            Obx(() {
              final selectedCategory = isHome
                  ? entryController.selectedCategory.value
                  : entryController.selectedUpdateCategory.value ??
                      entryController.updatedEntry?.category;

              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: entryController.categories.length,
                primary: false,
                itemBuilder: (context, index) {
                  final category = entryController.categories[index];

                  return Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: selectedCategory?.id == category.id
                          ? Colors.deepPurple[100]
                          : Colors.white,
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        state.didChange(category);
                        entryController.selectCategory(category, isHome);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconPicker.getIconById(category.iconId),
                            color: Colors.deepPurple,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
