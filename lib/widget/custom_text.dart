import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  const CustomText({super.key, required this.text, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
