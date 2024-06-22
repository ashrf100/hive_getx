import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/core/services/icon_picker.dart';
import 'package:hive_test/view/widgets/entry/custom_text_field.dart';
import 'package:hive_test/view/widgets/entry/save_button_widget.dart';

class AddCategoryForm extends GetView<CategoryController> {
  const AddCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.nameController,
                labelText: Strings.categoryName.tr,
                hintText: Strings.enterCategoryName.tr,
                prefixIcon: Icons.category,
                maxLength: 10,
                validator: controller.validator,
                onChanged: (value) {
                  controller.nameController.text = value;
                  controller.nameController.selection =
                      TextSelection.fromPosition(
                    TextPosition(offset: value.length),
                  );
                },
              ),
              const SizedBox(height: 8),
              const CategoryIconsList(),
              const SizedBox(height: 8),
              SaveButtonWidget(
                  onPressed: () {
                    controller.addCategoryButton();
                  },
                  buttonText: Strings.addCategory.tr)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryIconsList extends GetView<CategoryController> {
  const CategoryIconsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepPurple,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8.0),
        child: FormField<int>(
          validator: (value) {
            if (value == null) {
              return Strings.pleaseSelectIcon.tr;
            }
            return null;
          },
          builder: (FormFieldState<int> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.selectIcon.tr,
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 14),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: IconPicker.icons.length,
                  primary: false,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        state.didChange(index);
                        controller.selectedIconId.value = index;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: state.value == index
                                ? Colors.deepPurple
                                : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          IconPicker.icons[index],
                          color: state.value == index
                              ? Colors.deepPurple
                              : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}
