import 'package:flutter/material.dart';
import 'package:hive_test/Control/entry/entry_controller.dart';

class AmountFieldWidget extends StatelessWidget {
  final bool isHome;
  final EntryController entryController;

  const AmountFieldWidget({
    super.key,
    required this.isHome,
    required this.entryController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: isHome
          ? entryController.amountControllerHome
          : entryController.amountController,
      decoration: const InputDecoration(
        hintText: 'Enter amount',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      validator: entryController.validator,
    );
  }
}
