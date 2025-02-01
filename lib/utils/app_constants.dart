class AppConstants {
  static const String baseUrl = 'https://demo-api.devdata.top/api';
  static const String restaurantInfoEndpoint = '/RestaurantInfo/GetRestaurantInfo';

  // API Headers
  static const Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  // Static Categories
  static const List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Pizza', 'emoji': '🍕'},
    {'id': 2, 'name': 'Chicken', 'emoji': '🍗'},
    {'id': 3, 'name': 'Burger', 'emoji': '🍔'},
    {'id': 4, 'name': 'Platter', 'emoji': '🍽️'},
  ];
}