import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class MessageService {
  void showMessage(String message);
  void showSuccess(String message);
  void showError(String message);
}

class SnackBarMessageService implements MessageService {
  @override
  void showMessage(String message) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void showSuccess(String message) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void showError(String message) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      icon: Icon(Icons.error_outline, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }
}

class AlertDialogMessageService implements MessageService {
  @override
  void showMessage(String message) {
    _showDialog(message);
  }

  @override
  void showSuccess(String message) {
    _showDialog(message, icon: Icons.check_circle, color: Colors.green);
  }

  @override
  void showError(String message) {
    _showDialog(message, icon: Icons.error_outline, color: Colors.red);
  }

  void _showDialog(String message, {IconData? icon, Color? color}) {
    Get.dialog(
      AlertDialog(
        title: icon != null ? Icon(icon, color: color) : null,
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class FlutterToastMessageService implements MessageService {
  @override
  void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
