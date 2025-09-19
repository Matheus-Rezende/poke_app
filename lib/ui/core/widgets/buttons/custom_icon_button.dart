import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomIconButton({
    super.key,
    this.text = '',
    required this.icon,
    this.textStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Wrap(
        spacing: 8.0,
        children: [
          Text(text, style: textStyle),
          Icon(icon),
        ],
      ),
    );
  }
}
