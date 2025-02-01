import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next/routes/app_routes.dart';
import 'package:next/utils/config_files.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Next App',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
    );
  }
}