import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/Control/settings/app_services.dart';
import 'package:hive_test/core/const/strings.dart';
import 'package:hive_test/view/widgets/entry/custom_text_field.dart';
import 'package:hive_test/view/widgets/entry/category_field_widget.dart';
import 'package:hive_test/view/widgets/entry/save_button_widget.dart';

class BaseEntryForm extends StatelessWidget {
  final EntryController entryController;
  final bool isHome;

  const BaseEntryForm(
      {super.key, required this.entryController, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: isHome ? entryController.formKeyHome : entryController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  AppServices controller = Get.find<AppServices>();
                  return CustomTextField(
                    controller: isHome
                        ? entryController.amountControllerHome
                        : entryController.amountController,
                    labelText: Strings.enterDailySpending.tr,
                    hintText: Strings.amountHint.tr,
                    prefixIcon: Icons.account_balance_wallet,
                    suffixText: ' | ${controller.userSettings.value.currency}',
                    keyboardType: TextInputType.number,
                    validator: entryController.validator,
                  );
                }),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: isHome
                      ? entryController.noteControllerHome
                      : entryController.noteController,
                  labelText: Strings.addNote.tr,
                  hintText: Strings.noteHint.tr,
                  prefixIcon: Icons.lightbulb_outline,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 16),
                CategoryButtonWidget(
                  entryController: entryController,
                  isHome: isHome,
                ),
                const SizedBox(height: 8),
                SaveButtonWidget(
                  onPressed: () => entryController.saveEntry(isHome),
                  buttonText: Strings.saveButtonText.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
