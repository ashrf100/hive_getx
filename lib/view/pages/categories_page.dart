import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/category/category_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/core/services/icon_picker.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/view/widgets/category/add_category_form.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(
                title: Strings.addNewCategory.tr,
                subtitle: Strings.addCategorySubtitle.tr,
              ),
              const AddCategoryForm(),
              const Divider(),
              controller.categories.isNotEmpty
                  ? TitleSubtitleWidget(
                      subtitle: Strings.manageCategoriesSubtitle.tr,
                    )
                  : const SizedBox(),
              Obx(() {
                if (controller.categories.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: TitleSubtitleWidget(
                            subtitle: Strings.noCategoriesAdded.tr),
                      ),
                    ],
                  );
                } else {
                  return CategoryCardHelper(controller: controller);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCardHelper extends StatelessWidget {
  const CategoryCardHelper({
    super.key,
    required this.controller,
  });

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.categories.length,
            primary: false,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return CategoryCard(category: category, controller: controller);
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.controller,
  });

  final Category category;
  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurple,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
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
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              controller.deleteCategory(category.id);
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
