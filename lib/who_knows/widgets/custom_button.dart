import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.textColor,
  });

  final String imagePath;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(imagePath, fit: BoxFit.contain),
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
