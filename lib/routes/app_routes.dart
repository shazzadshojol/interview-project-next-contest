import 'package:get/get.dart';

import '../controllers_bindings.dart';
import '../screens/home/home_screens.dart';


class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: ControllersBindings(),
    ),
  ];
}


abstract class Routes {
  static const HOME = '/';
}