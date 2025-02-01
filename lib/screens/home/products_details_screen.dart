import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next/utils/config_files.dart';

import '../../data/models/products_model.dart';
import '../../widgets/product_bottom_bar.dart';
import '../../widgets/product_variation_option.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildImageSection(),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Variation Section

                    _buildVariationContainer(),
                    // Special Requests
                    SizedBox(height: 24),
                    Text(
                      'Special requests (Optional)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'e.g Hello',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Cart Section
          // _buildBottomPart(),
          ProductBottomBar(
            price: 120.0,
            onAddToCart: () {
              // Handle add to cart
            },
            onQuantityChanged: (quantity) {
              // Handle quantity changes
              print('New quantity: $quantity');
            },
            primaryColor: AppColors.primary,
            currencySymbol: '\$',
          ),
        ],
      ),
    );
  }

  //
  // Widget _buildBottomPart() {
  //   final cartCount = 1.obs;
  //
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 4,
  //           offset: Offset(0, -2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'AED ${product.price}',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xFFB71C1C),
  //                   ),
  //                 ),
  //                 Text(
  //                   '(1 item)',
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Spacer(),
  //             // Cart controls
  //             _cartControlContainer(cartCount),
  //           ],
  //         ),
  //         SizedBox(height: 5),
  //         SizedBox(
  //           width: double.maxFinite,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               // Add to cart logic
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColors.primary,
  //               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //               foregroundColor: Colors.white,
  //             ),
  //             child: Stack(
  //               children: [
  //                 // Centered container for text
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     'Add to cart',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //                 // Right aligned container for icon
  //                 Align(
  //                   alignment: Alignment.centerRight,
  //                   child: Icon(
  //                     Icons.mail_outline,
  //                     size: 20,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _cartControlContainer(RxInt cartCount) {
  //   return Row(
  //     children: [
  //       // Delete/Trash icon
  //       Container(
  //         decoration: BoxDecoration(
  //           color: Colors.grey[200], // Light gray background
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //         ),
  //         child: IconButton(
  //           icon: Icon(Icons.delete_outline, color: Colors.grey[600]),
  //           onPressed: () {
  //             if (cartCount.value <= 1) {
  //               Get.back();
  //             }
  //             cartCount.value = 1;
  //           },
  //           style: IconButton.styleFrom(
  //             padding: EdgeInsets.zero, // Reduces padding
  //             tapTargetSize:
  //                 MaterialTapTargetSize.shrinkWrap, // Makes the button compact
  //           ),
  //         ),
  //       ),
  //
  //       // Count display
  //       Obx(() => Container(
  //             width: 40,
  //             alignment: Alignment.center,
  //             child: Text(
  //               '${cartCount.value}',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           )),
  //       // Increase button
  //       Container(
  //         decoration: BoxDecoration(
  //           color: Colors.grey[200], // Light gray background
  //           borderRadius: BorderRadius.all(Radius.circular(8)),
  //         ),
  //         child: IconButton(
  //           icon: Icon(Icons.add, color: Color(0xFFB71C1C)),
  //           onPressed: () {
  //             cartCount.value++;
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildVariationContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add variation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '*Required',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            // Radio Button Options
            VariationOption(
              title: '1:1',
              price: 'AED ${product.price}',
              groupValue: '1:1',
              onChanged: (value) {},
            ),
            VariationOption(
              title: '1:2',
              price: 'AED ${product.price * 2}',
              groupValue: '1:1',
              onChanged: (value) {},
            ),
            VariationOption(
              title: '1:4',
              price: 'AED ${product.price * 4}',
              groupValue: '1:1',
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Image.network(
          product.imageUrl,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }
}
