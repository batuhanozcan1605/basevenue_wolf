import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../color_palette.dart';

class CustomMenuTile extends StatelessWidget {
  final String title;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomMenuTile({
    super.key,
    required this.title,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // Remove default padding
      title: Row(
        children: [
          // Vertical Stripe
          Container(
            width: 4, // Adjust width as needed
            height: 30, // Match icon height
            color: isSelected ? ColorPalette.primary : Colors.transparent,
          ),
          const SizedBox(width: 8), // Space between stripe and icon

          // Icon
          SvgPicture.asset(
            assetPath,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              isSelected ? ColorPalette.primary : Colors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8), // Space between icon and text

          // Text
          Text(
            title,
            style: TextStyle(
              color: isSelected ? ColorPalette.primary : Colors.white,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
