import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget widget;
  final EdgeInsetsGeometry? padding;
  final bool isSliverWidget;
  final double appBarHeight;
  final Color? backgroundColor;
  const CustomAppBarWidget({
    super.key,
    required this.widget,
    this.padding,
    this.isSliverWidget = false,
    this.appBarHeight = 100,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return isSliverWidget
        ? SliverAppBar(
            flexibleSpace: Container(
              color: backgroundColor ?? Colors.white,
              padding: padding ?? EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              width: MediaQuery.sizeOf(context).width,
              child: widget,
            ),
          )
        : SafeArea(
            child: Container(
              color: backgroundColor ?? Colors.white,
              padding: padding ?? EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              width: MediaQuery.sizeOf(context).width,
              child: widget,
            ),
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
