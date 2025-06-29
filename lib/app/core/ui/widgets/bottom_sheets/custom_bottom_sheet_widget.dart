import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poke_app/app/core/ui/widgets/bottom_sheets/custom_header_bottom_sheet_widget.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  final double height;
  const CustomBottomSheetWidget({super.key, required this.widget, required this.title, this.height = 500.0});

  @override
  Widget build(BuildContext context) {
    return CustomHeaderBottomSheetWidget(widget: widget, title: title, height: height);
  }

  static void show({
    required BuildContext context,
    required Widget widget,
    required String title,
    double height = 500.0,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      animationCurve: Curves.easeInOutCubicEmphasized,
      builder: (context) => CustomBottomSheetWidget(height: height, widget: widget, title: title),
    );
  }
}
