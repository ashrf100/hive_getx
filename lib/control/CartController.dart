import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/model/cart_item.dart';
import 'package:hive_test/core/const.dart';

class CartController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  late Box<CartItem> box;

  @override
  void onInit() { 
    box = Hive.box<CartItem>(boxName);
    super.onInit();
  }

  void deleteCartItem(int index) {
    box.deleteAt(index);
    update();
  }

  void addCartItem() {
    final name = nameController.text;
    final price = double.parse(priceController.text);
    final quantity = int.parse(quantityController.text);

    final newItem = CartItem(name: name, price: price, quantity: quantity);
    box.add(newItem);

    nameController.clear();
    priceController.clear();
    quantityController.clear();

    update();

    Get.back();
  }

  void editCartItem(int index) {
    final name = nameController.text;
    final price = double.parse(priceController.text);
    final quantity = int.parse(quantityController.text);

    final editedItem = CartItem(name: name, price: price, quantity: quantity);
    box.putAt(index, editedItem);

    nameController.clear();
    priceController.clear();
    quantityController.clear();

    update();

    Get.back();
  }

  void clearTextControllers() {
    nameController.clear();
    priceController.clear();
    quantityController.clear();
  }

  void increaseQuantity(int index) {
    CartItem item = box.getAt(index)!;
    item.quantity++;
    box.putAt(index, item);
    update();
  }

  void decreaseQuantity(int index) {
    CartItem item = box.getAt(index)!;
    if (item.quantity > 1) {
      item.quantity--;
      box.putAt(index, item);
      update();
    }
  }
}
