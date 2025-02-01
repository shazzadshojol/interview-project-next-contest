import 'package:flutter/material.dart';

class VariationOption extends StatelessWidget {
  final String title;
  final String price;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const VariationOption({
    super.key,
    required this.title,
    required this.price,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Radio(
            value: title,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: Color(0xFFB71C1C),
          ),
          Text(title),
          Spacer(),
          Text(
            price,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
