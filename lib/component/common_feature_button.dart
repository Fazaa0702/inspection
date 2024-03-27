import 'package:flutter/material.dart';

class CommonFeatureButton extends StatelessWidget {
  final Color buttonColor;
  final VoidCallback onPressed;
  final String image;
  final String text;

  const CommonFeatureButton(
      {super.key,
      required this.buttonColor,
      required this.onPressed,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: buttonColor),
            onPressed: onPressed,
            child: SizedBox(
              width: 50,
              height: 100,
              child: Image.asset(
                image,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
