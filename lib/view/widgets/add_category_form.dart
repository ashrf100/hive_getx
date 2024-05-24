import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category_Controller.dart';

class AddCategoryForm extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());

  AddCategoryForm({super.key});

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
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: controller.validator,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.addCategoryButton();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child:
                    const Text('Add Category', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
