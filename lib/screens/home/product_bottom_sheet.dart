import 'package:flutter/material.dart';

import '../../data/models/products_model.dart';
import '../../utils/config_files.dart';
import '../../widgets/product_bottom_bar.dart';

class ProductBottomSheet extends StatelessWidget {
  final Product product;

  const ProductBottomSheet({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6, // Initial height (60% of screen)
      minChildSize: 0.4, // Minimum height (40% of screen)
      maxChildSize: 1.0, // Maximum height (full screen)
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Product Image
                Hero(
                  tag: 'product-$product', // Add unique hero tag
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Additional product details (visible when expanded)
                      _buildExpandedDetails(),

                      const SizedBox(height: 16),

                      // Price and Add to Cart
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandedDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// How to show the bottom sheet:
void showProductSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for full-screen draggable sheet
    backgroundColor: Colors.transparent,
    builder: (context) => ProductBottomSheet(product: product),
  );
}
