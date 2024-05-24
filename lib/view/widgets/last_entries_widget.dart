import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry_controller.dart';

class LastEntriesWidget extends StatelessWidget {
  const LastEntriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return Obx(() {
      final entries = entryController.entries;
      final itemCount = entries.length >= 10 ? 10 : entries.length;
      final lastEntries = entries.sublist(entries.length - itemCount);

      if (entries.isEmpty) {
        return Center(
          child: Text(
            "No entries added yet",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        );
      }
      return ListView.builder(
        primary: false,
        shrinkWrap: true,
        reverse: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final entry = lastEntries[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  child: Text(
                    "${entry.amount} LE",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                  ),
                ),
                title: Text(" ${entry.category.name}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (entry.note != null)
                      Text(
                        entry.note!,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    Text(
                      "${entry.date}",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    entryController.deleteEntry(entry);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
