import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_filter_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'dart:convert';

class EntryFilterScreen extends GetView<EntryFilterController> {
  const EntryFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilder(
        key: controller.formKey,
        child: ListView(
          children: [
            TitleSubtitleWidget(
                title: Strings.paintYourSpendingPicture.tr,
                subtitle: Strings.filterExploreTransactions.tr),
            FilterForm(controller: controller),
            const SizedBox(height: 50),
            Obx(() {
              final filteredEntries = controller.filteredEntries;
              if (filteredEntries.isEmpty) {
                return Center(child: Text(Strings.noEntriesAddedYet.tr));
              } else {
                return Column(
                  children: [
                    SimpleBarChart(filteredEntries),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class FilterForm extends StatelessWidget {
  const FilterForm({
    super.key,
    required this.controller,
  });

  final EntryFilterController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'keyword',
              controller: controller.keywordController,
              decoration: InputDecoration(labelText: Strings.keywordInNotes.tr),
            ),
            const SizedBox(height: 8),
            FormBuilderDateTimePicker(
              name: 'fromDate',
              controller: controller.fromDateController,
              decoration: InputDecoration(labelText: Strings.fromDate.tr),
              format: DateFormat('yyyy-MM-dd'),
              inputType: InputType.date,
            ),
            const SizedBox(height: 8),
            FormBuilderDateTimePicker(
              name: 'toDate',
              controller: controller.toDateController,
              decoration: InputDecoration(labelText: Strings.toDate.tr),
              format: DateFormat('yyyy-MM-dd'),
              inputType: InputType.date,
            ),
            const SizedBox(height: 8),
            Obx(() {
              return FormBuilderDropdown<Category>(
                name: 'category',
                decoration:
                    InputDecoration(labelText: Strings.selectCategory.tr),
                items: [
                  DropdownMenuItem<Category>(
                    value: null,
                    child: Text(Strings.none.tr),
                  ),
                  ...controller.categories.map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                ],
                onChanged: (Category? newValue) {
                  controller.selectedCategory.value = newValue;
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.filterEntries,
              child: Text(Strings.filter.tr),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleBarChart extends StatefulWidget {
  final Map<Category, double> categoriesAmounts;

  const SimpleBarChart(this.categoriesAmounts, {super.key});

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        widget.categoriesAmounts.values.reduce((a, b) => a + b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.categoriesAmounts.keys.map((category) {
        double barWidth = totalAmount != 0
            ? (widget.categoriesAmounts[category]! / totalAmount) * 180
            : 0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  category.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    AnimatedContainer(
                      width: _animate ? barWidth : 0,
                      height: 20,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${widget.categoriesAmounts[category]!.toInt()} LE",
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class SimplePieChart extends StatelessWidget {
  final Map<Category, double> categoriesAmounts;

  const SimplePieChart(this.categoriesAmounts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [];
    categoriesAmounts.forEach((category, amount) {
      data.add({'value': amount, 'name': category.name});
    });

    String jsonData = jsonEncode(data);

    return SizedBox(
      height: 300,
      width: double.infinity, // Changed to double.infinity for full width
      child: Echarts(
        option: '''
          {
            tooltip: {
              trigger: 'item'
            },
            legend: {
              orient: 'vertical',
              left: 'left',
            },
            series: [{
              name: 'Categories',
              type: 'pie',
              radius: '75%',
              data: $jsonData,
              emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
              }
            }]
          }
        ''',
      ),
    );
  }
}
