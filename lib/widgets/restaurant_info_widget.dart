// lib/app/modules/home/views/widgets/restaurant_info_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next/data/models/restaurantModel.dart';

import '../screens/controllers/home_controller.dart';
import '../utils/config_files.dart';

class RestaurantInfoWidget extends GetWidget<HomeController> {
  const RestaurantInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final restaurant = controller.restaurantInfo.value;
      if (restaurant == null) return const SizedBox();

      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNameAndReview(restaurant),
            const SizedBox(height: 8),
            _buildDeliveryAndReview(restaurant),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_bike_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      restaurant.deliveryMode,
                      style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Min order ${restaurant.currency} ${restaurant.minOrderAmount}',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.info_circle,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'More info',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  Row _buildDeliveryAndReview(RestaurantModel restaurant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text('Delivery ${restaurant.averageDeliveryTime}',
                style: AppTextStyles.body),
            const SizedBox(width: 16),
            const Icon(CupertinoIcons.location,
                size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(restaurant.distance, style: AppTextStyles.body),
          ],
        ),
        Text(
          'Review',
          style: AppTextStyles.price,
        )
      ],
    );
  }

  Row _buildNameAndReview(RestaurantModel restaurant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(restaurant.name, style: AppTextStyles.heading),
            SizedBox(width: 4),
            Icon(
              CupertinoIcons.info_circle,
              color: Colors.grey,
              size: 20,
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.ratingYellow, size: 16),
                const SizedBox(width: 4),
                Text(restaurant.averageRating),
              ],
            ),
            Text(' ${restaurant.totalRating} + ratings',
                style: AppTextStyles.body2),
          ],
        ),
      ],
    );
  }
}
