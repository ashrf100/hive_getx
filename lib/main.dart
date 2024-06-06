import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/bindings.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/core/const/ui_constants.dart';
import 'package:hive_test/model/Category/category_model.dart';
import 'package:hive_test/model/Entry/entry_model.dart';
import 'package:hive_test/themedata.dart';
import 'package:hive_test/view/pages/bottom_nav_bar.dart';
import 'package:hive_test/view/widgets/entry/base_entry_form.dart';
import 'package:hive_test/view/widgets/home/last_entries_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

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
        home: const BottomNavBarScreen(),
        initialBinding: InitialBinding(),
        theme: AppThemes.lightTheme);
  }
}

class MyHomePage extends GetView<EntryController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
            left: UI.padMd, right: UI.padMd, top: UI.padMd),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleSubtitleWidget(
                title: "Track Daily Expenses",
                subtitle: "Manage Your Spending Easily",
              ),
              BaseEntryForm(entryController: controller, isHome: true),
              const SizedBox(height: UI.padSm),
              const TitleSubtitleWidget(subtitle: "Recent Expenses"),
              const LastEntriesWidget()
            ],
          ),
        ),
      )),
    );
  }
}
