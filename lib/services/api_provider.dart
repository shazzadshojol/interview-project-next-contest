import 'package:get/get.dart';
import '../utils/app_constants.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppConstants.baseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers.addAll(AppConstants.apiHeaders);
      return request;
    });
    super.onInit();
  }

  Future<Response> getRestaurantInfo() async {
    try {
      final response = await get(AppConstants.restaurantInfoEndpoint);
      if (response.status.hasError) {
        return Future.error('Error fetching restaurant info');
      }
      return response;
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}