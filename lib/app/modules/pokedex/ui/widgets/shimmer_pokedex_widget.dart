import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPokedexWidget extends StatelessWidget {
  const ShimmerPokedexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    final sizeOf = MediaQuery.sizeOf(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            spacing: 16.0,
            children: [
              Shimmer.fromColors(
                baseColor: appTheme.colors.greyColor.withValues(alpha: 0.4),
                highlightColor: appTheme.colors.greyColor.withValues(alpha: 0.1),
                child: Container(
                  height: 52.0,
                  width: sizeOf.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: appTheme.colors.whiteColor),
                    borderRadius: BorderRadius.all(Radius.circular(49.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(left: 16.0),
                    child: Row(
                      spacing: 24.0,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(width: 24.0, height: 24.0, color: appTheme.colors.whiteColor),
                        ),
                        Flexible(
                          flex: 4,
                          child: Container(width: 160.0, height: 16.0, color: appTheme.colors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: appTheme.colors.greyColor.withValues(alpha: 0.4),
                highlightColor: appTheme.colors.greyColor.withValues(alpha: 0.1),
                child: Container(
                  height: 42.0,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: appTheme.colors.whiteColor,
                  ),
                ),
              ),
              ...List.generate(10, (index) {
                return Shimmer.fromColors(
                  baseColor: appTheme.colors.greyColor.withValues(alpha: 0.4),
                  highlightColor: appTheme.colors.greyColor.withValues(alpha: 0.1),
                  enabled: true,
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: appTheme.colors.whiteColor,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
