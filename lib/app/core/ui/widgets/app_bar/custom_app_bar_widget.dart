import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  const CustomAppBarWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        width: MediaQuery.sizeOf(context).width,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
