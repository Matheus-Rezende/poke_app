import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  const CustomButtonWidget({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.backgroundColor,
    this.borderRadius = 16.0,
    this.padding = 16.0,
    this.width = 80.0,
    this.height = 32.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Center(child: Text(title, style: titleStyle)),
      ),
    );
  }
}
