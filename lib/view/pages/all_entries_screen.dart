import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/view/widgets/entry/entry_card.dart';
import 'package:hive_test/view/widgets/entry/pagination_controls.dart';
import 'package:intl/intl.dart';

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return SafeArea(
      child: Obx(() {
        final entries = entryController.paginationEntries;

        if (entries.isEmpty) {
          return Column(
            children: [
              const Expanded(
                child: Center(
                  child:
                      Text("No entries found", style: TextStyle(fontSize: 16)),
                ),
              ),
              PaginationControls(entryController: entryController),
            ],
          );
        }

        // Group entries by date
        Map<String, List<Entry>> groupedEntries = {};
        for (var entry in entries) {
          String dateKey = DateFormat('yyyy-MM-dd').format(entry.date);
          if (!groupedEntries.containsKey(dateKey)) {
            groupedEntries[dateKey] = [];
          }
          groupedEntries[dateKey]!.add(entry);
        }

        // Create a list of widgets with dividers and dates
        List<Widget> widgets = [];
        groupedEntries.forEach((date, entries) {
          // Add divider
          widgets.add(
            Divider(
              thickness: 2,
              color: Colors.grey[300],
              height: 30,
            ),
          );
          // Add date
          widgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          );
          // Add entries
          for (var entry in entries) {
            widgets.add(
              EntryCard(
                entry: entry,
                onDeleteTap: () => entryController.deleteEntry(entry),
              ),
            );
          }
        });

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: widgets,
              ),
            ),
            PaginationControls(entryController: entryController),
          ],
        );
      }),
    );
  }
}
