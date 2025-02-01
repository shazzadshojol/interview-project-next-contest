import 'package:get/get.dart';
import 'package:next/screens/controllers/home_controller.dart';
import 'package:next/services/api_provider.dart';

import 'data/repo/restaurant_repo.dart';


class ControllersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => RestaurantRepository(apiProvider: Get.find<ApiProvider>()));
    Get.lazyPut(() => HomeController(repository: Get.find<RestaurantRepository>()));
  }
}