// Create a new widget for the rotating banner
import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/config_files.dart';


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/config_files.dart';

class BannerController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;
  Timer? _timer;

  final List<Map<String, dynamic>> banners = [
    {
      'discount': '20%',
      'maxAmount': 300,
    },
    {
      'discount': '15%',
      'maxAmount': 200,
    },
    {
      'discount': '25%',
      'maxAmount': 400,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    startAutoRotation();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void startAutoRotation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < banners.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }
}

class PromotionalBannerWidget extends GetView<BannerController> {
  final String currency;

  const PromotionalBannerWidget({
    Key? key,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BannerController()); // Initialize controller

    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: (int page) => controller.currentPage.value = page,
              itemCount: controller.banners.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8), // Add gap between banners
                  decoration: BoxDecoration(
                    color: AppColors.discountRed,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.local_offer, color: Colors.white, size: 24),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            controller.banners[index]['discount'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'OFF',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'up to $currency ${controller.banners[index]['maxAmount']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Free delivery',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.95),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.banners.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentPage.value == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}