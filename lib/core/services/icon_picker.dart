import 'package:flutter/material.dart';

class IconPicker {
  static const List<IconData> icons = [
    Icons.home,
    Icons.work,
    Icons.school,
    Icons.shopping_cart,
    Icons.restaurant,
    Icons.directions_car,
    Icons.flight,
    Icons.local_grocery_store,
    Icons.fitness_center,
    Icons.healing,
    Icons.pets,
    Icons.sports_soccer,
    Icons.beach_access,
    Icons.cake,
    Icons.local_cafe,
    Icons.local_hospital,
    Icons.local_library,
    Icons.local_movies,
    Icons.music_note,
    Icons.videogame_asset,
  ];

  static IconData getIconById(int id) {
    return icons[id];
  }
}
