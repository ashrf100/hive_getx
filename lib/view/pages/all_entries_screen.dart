import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/view/widgets/entry/entry_card.dart';
import 'package:hive_test/view/widgets/entry/pagination_controls.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleSubtitleWidget(
                  title: Strings.spendingJourneyTitle.tr,
                  subtitle: Strings.spendingJourneySubtitle.tr,
                ),
                Expanded(
                  child: Center(
                    child: Text(Strings.noEntriesAddedYet.tr,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ),
                PaginationControls(entryController: entryController),
              ],
            ),
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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(
                title: Strings.spendingJourneyTitle.tr,
                subtitle: Strings.spendingJourneySubtitle.tr,
              ),
              Expanded(
                child: ListView(
                  children: widgets,
                ),
              ),
              PaginationControls(entryController: entryController),
            ],
          ),
        );
      }),
    );
  }
}
