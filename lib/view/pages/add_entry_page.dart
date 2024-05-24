import 'package:flutter/material.dart';
import 'package:hive_test/view/widgets/add_entry_form.dart';
import 'package:hive_test/view/widgets/last_entries_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

class AddEntryPage extends StatelessWidget {
  const AddEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(title: "Add New Entry"),
              const AddEntryForm(),
              const SizedBox(
                height: 16,
              ),
              TitleSubtitleWidget(
                  title: "Entries", subtitle: "Last 10 Entries"),
              LastEntriesWidget()
            ],
          ),
        ),
      ),
    );
  }
}
