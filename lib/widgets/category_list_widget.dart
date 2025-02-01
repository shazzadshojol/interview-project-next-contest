import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/controllers/home_controller.dart';
import '../utils/config_files.dart';

class CategoryListWidget extends GetView<HomeController> {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategoryIndex.value == index;
            return GestureDetector(
              onTap: () => controller.onCategoryTap(index),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(color: Colors.pink, width: 1)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.emoji,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected ? Colors.pink : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
