import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback backButton;

  const CommonAppBar(
      {super.key,
      required this.title, 
      this.backgroundColor,
      required this.backButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: backgroundColor ?? const Color(0xFF32A632),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(onPressed: backButton, icon: const Icon(Icons.arrow_back)),
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ],
      ),
      titleSpacing: 10,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
