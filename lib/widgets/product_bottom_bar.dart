import 'package:flutter/material.dart';

class ProductBottomBar extends StatefulWidget {
  final double price;
  final VoidCallback? onAddToCart;
  final ValueChanged<int>? onQuantityChanged;
  final Color primaryColor;
  final Color priceColor;
  final String currencySymbol;
  final String addToCartText;

  const ProductBottomBar({
    Key? key,
    required this.price,
    this.onAddToCart,
    this.onQuantityChanged,
    this.primaryColor = const Color(0xFFB71C1C),
    this.priceColor = const Color(0xFFB71C1C),
    this.currencySymbol = 'AED',
    this.addToCartText = 'Add to cart',
  }) : super(key: key);

  @override
  State<ProductBottomBar> createState() => _ProductBottomBarState();
}

class _ProductBottomBarState extends State<ProductBottomBar> {
  int _quantity = 1;

  void _updateQuantity(int newQuantity) {
    if (newQuantity < 1) return;
    setState(() {
      _quantity = newQuantity;
    });
    widget.onQuantityChanged?.call(newQuantity);
  }

  Widget _buildQuantityControls() {
    return Row(
      children: [
        _ControlButton(
          icon: Icons.delete_outline,
          onPressed: () => _updateQuantity(1),
          color: Colors.grey[600]!,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          child: Text(
            '$_quantity',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _ControlButton(
          icon: Icons.add,
          onPressed: () => _updateQuantity(_quantity + 1),
          color: Colors.grey[600]!,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.currencySymbol} ${widget.price}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.priceColor,
                    ),
                  ),
                  Text(
                    '($_quantity item${_quantity > 1 ? 's' : ''})',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildQuantityControls(),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                foregroundColor: Colors.white,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.addToCartText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      // Changed from mail_outline to shopping_cart_outlined
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
