import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  final double? height;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Size? fixedSize;
  final String text;

  const CommonButton(
      {super.key,
      this.height,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.fixedSize,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? const Color(0xFF47B347),
            fixedSize: fixedSize ?? Size(Get.width, 40)),
        child: Text(text,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins')),
      ),
    );
  }
}
