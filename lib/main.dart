import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/bindings.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/themedata.dart';
import 'package:hive_test/view/widgets/entry/base_entry_form.dart';
import 'package:hive_test/view/widgets/entry/update_entry_form.dart';
import 'package:hive_test/view/widgets/home/app_drawer.dart';
import 'package:hive_test/view/widgets/home/last_entries_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';
import 'package:intl/intl.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Entry>(EntryAdapter());
  await Hive.openBox<Entry>(entryBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: const MyHomePage(),
        initialBinding: InitialBinding(),
        theme: AppThemes.lightTheme);
  }
}

class MyHomePage extends GetView<EntryController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("home Page"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(title: "Fast Add New Entry "),
              BaseEntryForm(entryController: controller, isHome: true),
              TitleSubtitleWidget(
                  title: "Entries", subtitle: "Last 10 Entries"),
              const LastEntriesWidget()
            ],
          ),
        ),
      )),
    );
  }
}

class AllEntriesScreen extends StatelessWidget {
  const AllEntriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Entries'),
      ),
      body: Obx(() {
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

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return EntryListItem(entry: entries[index]);
                },
              ),
            ),
            PaginationControls(entryController: entryController),
          ],
        );
      }),
    );
  }
}

class EntryListItem extends GetView<EntryController> {
  final Entry entry;

  const EntryListItem({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(entry.date);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {
            Get.to(UpdateEntryForm(entry: entry));
          },
          leading: Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${entry.amount} LE",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(" ${entry.category.name}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.note != null)
                Text(
                  entry.note!,
                  style: const TextStyle(fontSize: 12),
                ),
              Text(
                "$formattedDate",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.deleteEntry(entry);
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}

class PaginationControls extends StatelessWidget {
  final EntryController entryController;

  const PaginationControls({Key? key, required this.entryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: entryController.currentPage.value > 1
                ? () {
                    entryController.currentPage.value -= 1;
                    entryController.loadPaginationEntries();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Previous'),
          ),
          const SizedBox(width: 20),
          Obx(() {
            return Text(
              'Page ${entryController.currentPage.value}',
              style: const TextStyle(fontSize: 16),
            );
          }),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: entryController.isNext.value
                ? () {
                    entryController.loadMoreEntries();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
