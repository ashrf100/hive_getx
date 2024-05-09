import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_test/control/CartController.dart';

class ClearTextControllers extends StatefulWidget {
  final Widget child;

  const ClearTextControllers({Key? key, required this.child}) : super(key: key);

  @override
  _ClearTextControllersState createState() => _ClearTextControllersState();
}

class _ClearTextControllersState extends State<ClearTextControllers> {
  @override
  void initState() {
    final CartController cartController = Get.find<CartController>();
    cartController.clearTextControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
