import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/bindings.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/view/widgets/entry/base_entry_form.dart';
import 'package:hive_test/view/widgets/home/app_drawer.dart';
import 'package:hive_test/view/widgets/home/last_entries_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Entry>(EntryAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: const MyHomePage(),
        initialBinding: InitialBinding(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
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
