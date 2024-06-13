import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/view/widgets/entry/entry_card.dart';

class LastEntriesWidget extends StatelessWidget {
  const LastEntriesWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return Obx(() {
      final lastEntries = entryController.valuesInRange;

      if (lastEntries.isEmpty) {
        return Center(
          child: Text(
            Strings.noEntriesAddedYet.tr,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: lastEntries.length <= 5 ? lastEntries.length : 5,
        itemBuilder: (context, index) {
          final entry = lastEntries[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: EntryCard(
              entry: entry,
              onDeleteTap: () => entryController.deleteEntry(entry),
            ),
          );
        },
      );
    });
  }
}
