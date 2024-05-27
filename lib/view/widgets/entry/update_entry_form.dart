import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/view/widgets/entry/base_entry_form.dart';

class UpdateEntryForm extends GetView<EntryController> {
  final Entry entry;

  const UpdateEntryForm({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    controller.updateEntry(entry);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Updat Entry'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: BaseEntryForm(
                    entryController: controller, isHome: false))));
  }
}
