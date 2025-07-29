import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum IconPosition { prefix, sufix }

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final IconPosition? iconPosition;
  final String? iconPath;
  final Color? borderColor;
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
    this.iconPosition,
    this.iconPath,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: borderColor != null ? Border.all(color: borderColor ?? Colors.white, width: 2.0) : null,
        ),
        child: switch (iconPosition) {
          IconPosition.prefix => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: [
              SvgPicture.asset(iconPath ?? ''),
              Text(title, style: titleStyle),
            ],
          ),
          IconPosition.sufix => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: [
              Text(title, style: titleStyle),
              SvgPicture.asset(iconPath ?? ''),
            ],
          ),
          _ => Center(child: Text(title, style: titleStyle)),
        },
      ),
    );
  }
}
