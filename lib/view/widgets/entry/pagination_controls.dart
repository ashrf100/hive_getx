import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/view/widgets/entry/save_button_widget.dart';

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
          SaveButtonWidget(
            buttonText: Strings.previous.tr, // use the translated string
            width: 130,
            onPressed: entryController.currentPage.value > 1
                ? () {
                    entryController.currentPage.value -= 1;
                    entryController.loadPaginationEntries();
                  }
                : null,
          ),
          const SizedBox(width: 20),
          Obx(() {
            return Text(
              '${Strings.page.tr} ${entryController.currentPage.value}', // use the translated string
              style: const TextStyle(fontSize: 16),
            );
          }),
          const SizedBox(width: 20),
          SaveButtonWidget(
            buttonText: Strings.next.tr, // use the translated string
            width: 130,
            onPressed: entryController.isNext.value
                ? () {
                    entryController.loadMoreEntries();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
