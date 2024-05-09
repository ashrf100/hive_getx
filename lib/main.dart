import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/core/const.dart';
import 'package:hive_test/model/cart_item.dart';
import 'package:hive_test/view/pages/MyHomePage.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CartItem>(CartItemAdapter());
  await Hive.openBox<CartItem>(boxName);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}



