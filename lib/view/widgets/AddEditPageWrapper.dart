import 'package:flutter/material.dart';

import 'package:hive_test/view/pages/AddEditPage.dart';
import 'package:hive_test/view/widgets/ClearTextControllers.dart';

class AddEditPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClearTextControllers(
      child: AddEditPage(),
    );
  }
}
