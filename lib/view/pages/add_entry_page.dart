import 'package:flutter/material.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/view/widgets/entry/update_entry_form.dart';

class UpdateEntryPage extends StatelessWidget {
  final Entry updatedEntry;
  const UpdateEntryPage({Key? key, required this.updatedEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updat Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: UpdateEntryForm(entry: updatedEntry),
        ),
      ),
    );
  }
}
