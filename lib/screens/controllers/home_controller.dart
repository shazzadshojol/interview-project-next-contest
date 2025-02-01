import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/products_model.dart';
import '../../data/models/restaurantModel.dart';
import '../../data/repo/restaurant_repo.dart';

class HomeController extends GetxController {
  final RestaurantRepository repository;
  final restaurantInfo = Rxn<RestaurantModel>();
  final selectedCategoryIndex = 0.obs;
  final isLoading = true.obs;
  final scrollController = ScrollController();
  final categories = <Category>[].obs;

  HomeController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchRestaurantInfo();
    setupDummyData();
    setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      updateSelectedCategoryFromScroll();
    });
  }

  void updateSelectedCategoryFromScroll() {
    if (scrollController.positions.isEmpty) return;

    final scrollPosition = scrollController.position.pixels;
    final viewportHeight = scrollController.position.viewportDimension;

    // Constants for section heights
    const double bannerHeight = 200.0; // Banner image
    const double restaurantInfoHeight = 150.0; // Restaurant info + offer banner
    const double categoryHeaderHeight = 60.0; // Category sticky header
    const double sectionHeaderHeight =
        52.0; // Category section title height (emoji + text)
    const double productCardHeight = 140.0; // Single product card height
    const int productsPerCategory = 2;

    // Total height of one category section (header + products)
    final double categoryTotalHeight =
        sectionHeaderHeight + (productCardHeight * productsPerCategory);

    // Skip calculation if we're in the fixed elements area
    final double fixedElementsHeight = bannerHeight + restaurantInfoHeight;
    if (scrollPosition < fixedElementsHeight) {
      if (selectedCategoryIndex.value != 0) selectedCategoryIndex.value = 0;
      return;
    }

    // Calculate visible areas for each category section
    Map<int, double> visibleAreas = {};

    for (int i = 0; i < categories.length; i++) {
      // Calculate the start and end positions of this category section
      final double sectionStart =
          fixedElementsHeight + (i * categoryTotalHeight);
      final double sectionEnd = sectionStart + categoryTotalHeight;

      // Calculate how much of this section is visible in the viewport
      final double visibleTop = math.max(scrollPosition, sectionStart);
      final double visibleBottom =
          math.min(scrollPosition + viewportHeight, sectionEnd);

      // If section is visible at all
      if (visibleBottom > visibleTop) {
        visibleAreas[i] = visibleBottom - visibleTop;
      }
    }

    // Find the category with maximum visible area
    if (visibleAreas.isNotEmpty) {
      final int maxVisibleIndex = visibleAreas.entries
          .reduce((curr, next) => curr.value > next.value ? curr : next)
          .key;

      // Update selected category if different
      if (selectedCategoryIndex.value != maxVisibleIndex) {
        selectedCategoryIndex.value = maxVisibleIndex;
      }
    }
  }

  void onCategoryTap(int index) {
    // Constants
    const double bannerHeight = 200.0;
    const double restaurantInfoHeight = 150.0;
    const double categoryHeaderHeight = 60.0;
    const double sectionHeaderHeight = 52.0;
    const double productCardHeight = 140.0;
    const int productsPerCategory = 2;

    final double fixedElementsHeight = bannerHeight + restaurantInfoHeight;
    final double categoryTotalHeight =
        sectionHeaderHeight + (productCardHeight * productsPerCategory);

    // Calculate position to scroll to
    final double scrollTarget =
        fixedElementsHeight + (index * categoryTotalHeight);

    // Scroll to the category section
    scrollController.animateTo(
      scrollTarget,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  double calculateVisibility(
    double itemOffset,
    double itemHeight,
    double scrollOffset,
    double viewportHeight,
  ) {
    final itemTop = itemOffset - scrollOffset;
    final itemBottom = itemTop + itemHeight;

    if (itemTop >= viewportHeight || itemBottom <= 0) {
      return 0.0;
    }

    final visibleTop = itemTop < 0 ? 0 : itemTop;
    final visibleBottom =
        itemBottom > viewportHeight ? viewportHeight : itemBottom;

    return visibleBottom - visibleTop;
  }

  Future<void> fetchRestaurantInfo() async {
    try {
      isLoading.value = true;
      final result = await repository.getRestaurantInfo();
      restaurantInfo.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load restaurant information',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setupDummyData() {
    categories.value = [
      Category(
        id: '1',
        name: 'Burger',
        emoji: '🍔',
        products: [
          Product(
            name: 'Margherita Burger',
            description: 'Classic pizza with tomato sauce and mozzarella',
            weight: '250 gm',
            price: 120,
            originalPrice: 150,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/JPWchHE.png',
            categoryId: '1',
            isShowVariant: true,
          ),
          Product(
            name: 'Pepperoni Burger',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/Yo12VcC.png',
            categoryId: '1',
          ),
        ],
      ),
      Category(
        id: '1',
        name: 'Pizza',
        emoji: '🍕',
        products: [
          Product(
              name: 'Margherita Pizza',
              description: 'Classic pizza with tomato sauce and mozzarella',
              weight: '250 gm',
              price: 120,
              originalPrice: 150,
              isPopular: true,
              imageUrl: 'https://i.imgur.com/wvdAw33.png',
              categoryId: '1',
              isShowVariant: true),
          Product(
            name: 'Pepperoni Pizza',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/Mv6K61t.png',
            categoryId: '1',
          ),
        ],
      ),
      Category(
        id: '2',
        name: 'Chicken',
        emoji: '🍗',
        products: [
          Product(
            name: 'Grilled Chicken',
            description: 'Tender grilled chicken with herbs',
            weight: '200 gm',
            price: 90,
            originalPrice: 110,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/JLAFupN.png',
            categoryId: '2',
          ),
          Product(
            name: 'Fried Chicken',
            description: 'Crispy fried chicken',
            weight: '200 gm',
            price: 85,
            originalPrice: 100,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/dYwbl1T.png',
            categoryId: '2',
          ),
        ],
      ),
      Category(
        id: '1',
        name: 'Platter',
        emoji: '🥙',
        products: [
          Product(
            name: 'Margherita Pizza',
            description: 'Classic pizza with tomato sauce and mozzarella',
            weight: '250 gm',
            price: 120,
            originalPrice: 150,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/qAuEAS7.png',
            categoryId: '1',
          ),
          Product(
            name: 'Pepperoni Pizza',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/tbo1zHV.png',
            categoryId: '1',
          ),
        ],
      ),
      Category(
        id: '1',
        name: 'Item 4',
        emoji: '🌭',
        products: [
          Product(
            name: 'Margherita Pizza',
            description: 'Classic pizza with tomato sauce and mozzarella',
            weight: '250 gm',
            price: 120,
            originalPrice: 150,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/hN875cx.png',
            categoryId: '1',
          ),
          Product(
            name: 'Pepperoni Pizza',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/JJToyLt.png',
            categoryId: '1',
          ),
        ],
      ),
      Category(
        id: '1',
        name: 'item 5',
        emoji: '🍟',
        products: [
          Product(
            name: 'Margherita Pizza',
            description: 'Classic pizza with tomato sauce and mozzarella',
            weight: '250 gm',
            price: 120,
            originalPrice: 150,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/hN875cx.png',
            categoryId: '1',
          ),
          Product(
            name: 'Pepperoni Pizza',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/JJToyLt.png',
            categoryId: '1',
          ),
        ],
      ),
      Category(
        id: 'item 6',
        name: 'Pizza',
        emoji: '🍕',
        products: [
          Product(
            name: 'Margherita Pizza',
            description: 'Classic pizza with tomato sauce and mozzarella',
            weight: '250 gm',
            price: 120,
            originalPrice: 150,
            isPopular: true,
            imageUrl: 'https://i.imgur.com/hN875cx.png',
            categoryId: '1',
          ),
          Product(
            name: 'Pepperoni Pizza',
            description: 'Pizza topped with pepperoni and cheese',
            weight: '250 gm',
            price: 130,
            originalPrice: 160,
            isPopular: false,
            imageUrl: 'https://i.imgur.com/JJToyLt.png',
            categoryId: '1',
          ),
        ],
      ),
    ];
  }
}
