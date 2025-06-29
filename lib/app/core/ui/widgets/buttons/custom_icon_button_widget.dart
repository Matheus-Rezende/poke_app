import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomIconButtonWidget({
    super.key,
    this.text = '',
    required this.icon,
    this.textStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();

    return InkWell(
      onTap: onPressed,
      child: Wrap(
        spacing: 8.0,
        children: [
          Text(
            text,
            style: textStyle ?? appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w600),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
