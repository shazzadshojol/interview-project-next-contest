import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next/screens/home/product_bottom_sheet.dart';
import 'package:next/screens/home/products_details_screen.dart';

import '../../data/models/products_model.dart';
import '../../widgets/category_list_widget.dart';
import '../../widgets/product_card_widget.dart';
import '../../widgets/promo_banner.dart';
import '../../widgets/restaurant_info_widget.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              // Banner Image
              SliverToBoxAdapter(
                child: Obx(
                  () => controller.restaurantInfo.value?.profileImageUrl != null
                      ? Image.network(
                          controller.restaurantInfo.value!.profileImageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image)),
                        ),
                ),
              ),

              // Restaurant Info Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const RestaurantInfoWidget(),
                    PromotionalBannerWidget(
                      currency:
                          controller.restaurantInfo.value?.currency ?? 'AED',
                    ),
                  ],
                ),
              ),

              // Categories Section
              const SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: CategoryListWidget(),
                  ),
                ),
                pinned: true,
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 8), // Adds 8dp gap
              ),

              // Products Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: Obx(() => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, categoryIndex) {
                          final category = controller.categories[categoryIndex];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '${category.emoji} ${category.name}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...category.products.map((product) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: ProductCardWidget(
                                      name: product.name,
                                      description: product.description,
                                      weight: product.weight,
                                      price: product.price,
                                      originalPrice: product.originalPrice,
                                      isPopular: product.isPopular,
                                      imageUrl: product.imageUrl,
                                      onTap: () => onProductTap(product),
                                    ),
                                  )),
                            ],
                          );
                        },
                        childCount: controller.categories.length,
                      ),
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }

  void onProductTap(Product product) {
    if (product.isShowVariant) {
      Get.to(() => ProductDetailScreen(product: product));
    } else {
      Get.bottomSheet(
        ProductBottomSheet(product: product),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const _SliverAppBarDelegate({
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(child: child),
          const SizedBox(height: 4), // Small gap before the underline
        ],
      ),
    );
  }

  @override
  double get maxExtent => 64; // Increased slightly to accommodate the gap

  @override
  double get minExtent => 64; // Increased slightly to accommodate the gap

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
