import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/core/const/ui_constants.dart';

import 'package:hive_test/view/widgets/entry/base_entry_form.dart';
import 'package:hive_test/view/widgets/home/last_entries_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

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
              TitleSubtitleWidget(
                  title: Strings.trackDailyExpenses.tr,
                  subtitle: Strings.manageSpendingEasily.tr),
              BaseEntryForm(entryController: controller, isHome: true),
              const SizedBox(height: UI.padSm),
              TitleSubtitleWidget(subtitle: Strings.recentExpenses.tr),
              const LastEntriesWidget()
            ],
          ),
        ),
      )),
    );
  }
}
