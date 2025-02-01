
import '../../services/api_provider.dart';
import '../models/restaurantModel.dart';

class RestaurantRepository {
  final ApiProvider apiProvider;

  RestaurantRepository({required this.apiProvider});

  Future<RestaurantModel> getRestaurantInfo() async {
    try {
      final response = await apiProvider.getRestaurantInfo();
      if (response.body['status'] == 200) {
        return RestaurantModel.fromJson(response.body['data']);
      } else {
        throw Exception('Failed to load restaurant info');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}