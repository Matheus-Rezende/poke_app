import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget widget;

  final double appBarHeight;

  const CustomAppBarWidget({super.key, required this.widget, this.appBarHeight = 100});

  @override
  Widget build(BuildContext context) {
    return widget;
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
