import 'package:flutter/material.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';
import 'package:hive_test/view/widgets/entry/amount_field_widget.dart';
import 'package:hive_test/view/widgets/entry/category_field_widget.dart';
import 'package:hive_test/view/widgets/entry/note_field_widget.dart';
import 'package:hive_test/view/widgets/entry/save_button_widget.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

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
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: isHome ? entryController.formKeyHome : entryController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isHome) TitleSubtitleWidget(title: "Amount"),
                AmountFieldWidget(
                    isHome: isHome, entryController: entryController),
                const SizedBox(height: 16),
                if (!isHome)
                  NoteFieldWidget(
                      isHome: isHome, entryController: entryController),
                if (!isHome) const SizedBox(height: 16),
                if (!isHome) TitleSubtitleWidget(title: "Category"),
                CategoryFieldWidget(
                  entryController: entryController,
                  isHome: isHome,
                ),
                if (!isHome) const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                SaveButtonWidget(
                  onPressed: () => entryController.saveEntry(isHome),
                ),
                if (isHome) buildAdvancedEntryLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAdvancedEntryLink(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: Text(
            "For Advanced Adding Entry\nTap Here",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
