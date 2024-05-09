import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_test/view/widgets/AddEditPageWrapper.dart';
import 'package:hive_test/view/widgets/CartListPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddEditPageWrapper());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: CartListPage(),
    );
  }
}
