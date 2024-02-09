import 'package:flutter/material.dart';
import 'package:whatsapp0909/common/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({
    super.key, 
    required this.onPressed, 
    required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: tabColor,
        minimumSize: const Size(double.infinity, 50)
      ), 
      child: Text(
        text,
        style: const TextStyle(
          color: blackColor
        ),
      ),
    );
  }
}