import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_test/Control/settings/app_services.dart';
import 'package:hive_test/bindings.dart';
import 'package:hive_test/core/localization/translations.dart';
import 'package:hive_test/themedata.dart';
import 'package:hive_test/view/pages/bottom_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart ';


void main() async {
  await initializeAppServices();

  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppServices controller = Get.put<AppServices>(AppServices());

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 690),
      builder: (context, child) => GetMaterialApp(
        home: const BottomNavBarScreen(),
        initialBinding: InitialBinding(),
        translations: MyTranslations(),
        locale: Locale(controller.userSettings.value.language),
        theme: controller.userSettings.value.isDarkMode
            ? AppThemes.darkTheme
            : AppThemes.lightTheme));
  }
}
