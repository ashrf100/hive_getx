import 'package:flutter/material.dart';
import 'package:hive_test/main.dart';
import 'package:hive_test/view/pages/all_entries_screen.dart';
import 'package:hive_test/view/pages/categories_page.dart';
import 'package:hive_test/view/pages/entry_filter_page.dart';
import 'package:hive_test/view/pages/my_home_page.dart';
import 'package:hive_test/view/pages/settings_page.dart';

import '../../core/const/ui_constants.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MyHomePage(),
    const CategoryPage(),
    const AllEntriesScreen(),
    const EntryFilterScreen(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UI.surface,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        iconSize: UI.iconMd,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Entries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_outlined),
            label: 'Filters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Backup',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: UI.primary, // Use primary color from UI constants
        onTap: _onItemTapped,
      ),
    );
  }
}
