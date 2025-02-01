class AppConstants {
  static const String baseUrl = 'https://demo-api.devdata.top/api';

  static const String restaurantInfoEndpoint =
      '/RestaurantInfo/GetRestaurantInfo';

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

  // images

  static const String burger1 =
      'https://static.vecteezy.com/system/resources/thumbnails/023/809/530/small/a-flying-burger-with-all-the-layers-ai-generative-free-photo.jpg';
  static const String burger2 =
      'https://t4.ftcdn.net/jpg/05/61/78/69/360_F_561786951_IdQbtR0bga3RzISgodGvIRMFEBqmjfcn.jpg';

  static const String pizza1 =
      'https://media.istockphoto.com/id/1442417585/photo/person-getting-a-piece-of-cheesy-pepperoni-pizza.jpg?s=612x612&w=0&k=20&c=k60TjxKIOIxJpd4F4yLMVjsniB4W1BpEV4Mi_nb4uJU=';
  static const String pizza2 =
      'https://septemberfarmcheese.b-cdn.net/wp-content/uploads/Blogs/Homemade-Pizza/homemade-pizza-monterey-jack-cheese.jpg';
  static const String chicken1 =
      'https://www.seriouseats.com/thmb/Xg3PF38VgjCJ84927mLRBorlMoU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SEA-the-best-barbecue-chicken-recipe-hero-updated-9cb214fe8fe8438992e049f8be51a708.jpg';
  static const String chicken2 =
      'https://www.foodandwine.com/thmb/Km8A0Dc_s5E8alSiWbehwuk8gI4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Grilled-Tandori-Chicken-FT-RECIPE0323-de1e247b1dbb4c0e9cb11243141eaa50.jpg';
  static const String food1 =
      'https://img.lovepik.com/photo/48023/7239.jpg_wh300.jpg';
  static const String food2 =
      'https://c1.wallpaperflare.com/preview/944/943/584/fork-strawberry-berry-dip.jpg';
}
