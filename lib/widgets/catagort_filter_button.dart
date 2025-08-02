import 'package:flutter/material.dart';
import 'package:market_nest/utils/colors.dart';

class CategoryFilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryFilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? greenColor : whiteColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: greyColor),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? whiteColor : greyColor),
        ),
      ),
    );
  }
}
