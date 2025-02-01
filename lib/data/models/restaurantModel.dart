class RestaurantModel {
  final String name;
  final String profileImageUrl;
  final String averageDeliveryTime;
  final String averageRating;
  final String totalRating;
  final int minOrderAmount;
  final String currency;
  final String deliveryMode;
  final String distance;

  RestaurantModel({
    required this.name,
    required this.profileImageUrl,
    required this.averageDeliveryTime,
    required this.averageRating,
    required this.totalRating,
    required this.minOrderAmount,
    required this.currency,
    required this.deliveryMode,
    required this.distance,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['Name'] ?? '',
      profileImageUrl: json['ProfileImageUrl'] ?? '',
      averageDeliveryTime: json['AverageDeliveryTime'] ?? '',
      averageRating: json['AverageRating'] ?? '',
      totalRating: json['TotalRating'] ?? '',
      minOrderAmount: json['MinOrderAmount'] ?? 0,
      currency: json['Currency'] ?? '',
      deliveryMode: json['DeliveryMode'] ?? '',
      distance: json['Distance'] ?? '',
    );
  }
}