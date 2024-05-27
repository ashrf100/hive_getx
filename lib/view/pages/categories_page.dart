import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_controller.dart';
import 'package:hive_test/view/widgets/category/add_category_form.dart';

import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());

  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(title: 'Your Categories'),
              Obx(() {
                if (controller.categories.isEmpty) {
                  return Center(
                    child: TitleSubtitleWidget(
                        subtitle: 'You haven\'t added any categories yet.'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: controller.categories.map((category) {
                        return Chip(
                          label: Text(category.name),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            controller.deleteCategory(category.id);
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
              }),
              const Divider(),
              TitleSubtitleWidget(
                title: 'Add New Category',
                subtitle: "You can add up to 10 categories.",
              ),
              AddCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
