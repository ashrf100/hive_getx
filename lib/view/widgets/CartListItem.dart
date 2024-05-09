import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_test/control/CartController.dart';
import 'package:hive_test/model/cart_item.dart';
import 'package:hive_test/view/pages/AddEditPage.dart';

class CartListItem extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartListItem({
    required this.item,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Card(
      child: ListTile(
        onTap: () {
          Get.to(AddEditPage(), arguments: {"item": item, "index": index});
        },
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: \$${item.price.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Quantity: '),
                IconButton(
                  onPressed: () {
                    cartController.decreaseQuantity(index);
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(item.quantity.toString()),
                IconButton(
                  onPressed: () {
                    cartController.increaseQuantity(index);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            cartController.deleteCartItem(index);
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
