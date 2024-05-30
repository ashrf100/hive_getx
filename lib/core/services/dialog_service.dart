import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';

abstract class DialogService {
  Future<void> showConfirmationDialog(
      {required String title,
      required String content,
      required VoidCallback onConfirm});
}

class FlutterDialogService implements DialogService {
  @override
  Future<void> showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

class FlutterDialogsDialogService implements DialogService {
  @override
  Future<void> showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) async {
    await showPlatformDialog(
      context: Get.context!,
      builder: (_) => BasicDialogAlert(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text('Cancel'),
            onPressed: () => Navigator.of(Get.context!).pop(),
          ),
          BasicDialogAction(
            title: const Text('Confirm'),
            onPressed: () {
              onConfirm();
              Navigator.of(Get.context!).pop();
            },
          ),
        ],
      ),
    );
  }
}
