import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/entry_controller.dart';
import 'package:hive_test/view/pages/add_entry_page.dart';
import 'package:hive_test/view/widgets/title_subtitle_widget.dart';

class AddEntryForm extends StatelessWidget {
  final bool isHome;
  const AddEntryForm({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: entryController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isHome) TitleSubtitleWidget(title: "Amount"),
                _buildAmountField(entryController),
                const SizedBox(height: 16),
                if (!isHome) _buildNoteField(entryController),
                if (!isHome) const SizedBox(height: 16),
                if (!isHome) TitleSubtitleWidget(title: "Category"),
                _buildCategoryChips(entryController),
                if (!isHome) const SizedBox(height: 16),
                Divider(),
                const SizedBox(height: 16),
                _buildSaveButton(entryController),
                if (isHome) _buildAdvancedEntryLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(EntryController entryController) {
    return TextFormField(
      controller: entryController.amountController,
      decoration: const InputDecoration(
        hintText: 'Enter amount',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      validator: entryController.validator,
    );
  }

  Widget _buildNoteField(EntryController entryController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSubtitleWidget(title: "Note"),
        TextFormField(
          controller: entryController.noteController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Enter note (optional)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.note),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips(EntryController entryController) {
    return Obx(() {
      return Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: entryController.categories.map((category) {
          return ChoiceChip(
            label: Text(category.name),
            selected: entryController.selectedCategory.value?.id == category.id,
            onSelected: (bool selected) {
              if (selected) {
                entryController.selectCategory(category);
              }
            },
            selectedColor: Colors.deepPurple.withOpacity(0.5),
          );
        }).toList(),
      );
    });
  }

  Widget _buildSaveButton(EntryController entryController) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      icon: const Icon(Icons.save),
      onPressed: () {
        if (entryController.formKey.currentState!.validate()) {
          if (entryController.selectedCategory.value?.id != null) {
            entryController.saveEntry();
          } else {
            Get.showSnackbar(const GetSnackBar(
              isDismissible: true,
              duration: Duration(seconds: 2),
              message: "Please choose a category",
              backgroundColor: Colors.red,
            ));
          }
        }
      },
      label: const Text('Save', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildAdvancedEntryLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddEntryPage()),
        );
      },
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
