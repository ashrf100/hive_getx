import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20';
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
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubtitleWidget(
                  title: Strings.trackDailyExpenses.tr,
                  subtitle: Strings.manageSpendingEasily.tr),
              BaseEntryForm(entryController: controller, isHome: true),
              SizedBox(height: 8.h),
              TitleSubtitleWidget(subtitle: Strings.recentExpenses.tr),
              const LastEntriesWidget()
            ],
          ),
        ),
      )),
    );
  }
}
