import 'package:flutter/material.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';

class NoteFieldWidget extends StatelessWidget {
  const NoteFieldWidget({
    super.key,
    required this.isHome,
    required this.entryController,
  });

  final bool isHome;
  final EntryController entryController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: isHome
          ? entryController.noteControllerHome
          : entryController.noteController,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Enter note (optional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.note),
      ),
    );
  }
}
