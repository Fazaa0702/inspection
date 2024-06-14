import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFormField extends StatelessWidget {
  const CommonFormField(
      {super.key,
      required this.question,
      this.controller,
      required this.readOnly,
      this.initValue,
      this.onChanged,
      this.width,
      this.leftPadding});
  final double? width;
  final String question;
  final TextEditingController? controller;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? initValue;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: leftPadding ?? 5.0, bottom: 3),
          child: Text(
            question,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
          ),
        ),
        SizedBox(
          width: width ?? Get.width * 0.90,
          child: TextFormField(
            maxLines: 5,
            minLines: 1,
            initialValue: initValue,
            readOnly: readOnly,
            // maxLength: 100,
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
            // maxLines: null,
            cursorColor: const Color(0xFF47B347),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF47B347)))),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }
}
