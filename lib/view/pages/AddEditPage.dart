import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/control/CartController.dart';
import 'package:hive_test/model/cart_item.dart';

class AddEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    final arguments = Get.arguments;
    final isEditing = arguments != null && arguments["item"] != null;
    final CartItem? item = isEditing ? arguments!["item"] : null;
    final int? index = isEditing ? arguments!["index"] : null; 

    if (isEditing) {
      cartController.nameController.text = item!.name;
      cartController.priceController.text = item.price.toString();
      cartController.quantityController.text = item.quantity.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Cart Item' : 'Add Cart Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cartController.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: cartController.priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: cartController.quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  cartController.editCartItem(index!);
                } else {
                  cartController.addCartItem();
                }
              },
              child: Text(isEditing ? 'Save Changes' : 'Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
