import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/control/CartController.dart';
import 'package:hive_test/model/cart_item.dart';
import 'package:hive_test/view/widgets/CartListItem.dart';

class CartListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        var box = controller.box;
        if (box.values.isEmpty) {
          return Center(
            child: Text('No items in the cart'),
          );
        }
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            CartItem item = box.getAt(index)!;
            return CartListItem(item: item, index: index);
          },
        );
      },
    );
  }
}
