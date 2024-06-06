import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_filter_controller.dart';
import 'package:hive_test/model/Category/category_model.dart';
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
            FormBuilderTextField(
              name: 'keyword',
              controller: controller.keywordController,
              decoration: const InputDecoration(labelText: 'Keyword in Notes'),
            ),
            const SizedBox(height: 8),
            FormBuilderDateTimePicker(
              name: 'fromDate',
              controller: controller.fromDateController,
              decoration: const InputDecoration(labelText: 'From Date'),
              format: DateFormat('yyyy-MM-dd'),
              inputType: InputType.date,
            ),
            const SizedBox(height: 8),
            FormBuilderDateTimePicker(
              name: 'toDate',
              controller: controller.toDateController,
              decoration: const InputDecoration(labelText: 'To Date'),
              format: DateFormat('yyyy-MM-dd'),
              inputType: InputType.date,
            ),
            const SizedBox(height: 8),
            Obx(() {
              return FormBuilderDropdown<Category>(
                name: 'category',
                decoration: const InputDecoration(labelText: 'Select Category'),
                items: [
                  const DropdownMenuItem<Category>(
                    value: null,
                    child: Text('None'),
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
              child: const Text('Filter'),
            ),
            const SizedBox(height: 50),
            Obx(() {
              final filteredEntries = controller.filteredEntries;
              if (filteredEntries.isEmpty) {
                return const Center(child: Text('No entries found.'));
              } else {
                return SimpleBarChart(filteredEntries);
              }
            }),
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

    String jsonData = jsonEncode(data); // Convert data to JSON string

    return SizedBox(
      height: 300,
      width: 200,
      child: Echarts(
        option: '''
          {
            series: [{
              type: 'pie',
              radius: ['40%', '70%'],
              avoidLabelOverlap: false,
              label: {
                show: false,
                position: 'center',
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '20',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: $jsonData // Use jsonData instead of data
            }]
          }
        ''',
      ),
    );
  }
}
