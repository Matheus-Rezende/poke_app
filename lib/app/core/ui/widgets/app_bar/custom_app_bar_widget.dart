import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget widget;
  final EdgeInsetsGeometry? padding;
  final double appBarHeight;
  final Color? backgroundColor;
  const CustomAppBarWidget({
    super.key,
    required this.widget,
    this.padding,
    this.appBarHeight = 100,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(padding: padding, width: MediaQuery.sizeOf(context).width, child: widget);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
