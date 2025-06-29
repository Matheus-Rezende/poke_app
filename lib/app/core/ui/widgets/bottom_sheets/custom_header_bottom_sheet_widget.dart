import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class CustomHeaderBottomSheetWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  final double height;
  const CustomHeaderBottomSheetWidget({
    super.key,
    required this.widget,
    required this.title,
    this.height = 500.0,
  });

  @override
  Widget build(BuildContext context) {
    var appTheme = Modular.get<AppTheme>();
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            height: 3.0,
            width: 38.0,
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: appTheme.colors.greyE6Color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(title, style: appTheme.typography.poppins16px().copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 32.0),
                  widget,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
