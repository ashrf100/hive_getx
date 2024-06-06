import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/view/pages/all_entries_screen.dart';
import 'package:hive_test/view/pages/backup_page.dart';
import 'package:hive_test/view/pages/categories_page.dart';
import 'package:hive_test/view/pages/entry_filter_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Navigation',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Get.to(CategoryPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.transit_enterexit),
            title: const Text('Entries'),
            onTap: () {
              Get.to(AllEntriesScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Reports'),
            onTap: () {
              Get.to(EntryFilterScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: const Text('Import/Export'),
            onTap: () {
              Get.to(BackupScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
