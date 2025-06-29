import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPokedexWidget extends StatelessWidget {
  const ShimmerPokedexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 12.0,
            children: [
              Shimmer.fromColors(
                baseColor: appTheme.colors.greyColor.withValues(alpha: 0.4),
                highlightColor: appTheme.colors.greyColor.withValues(alpha: 0.1),
                child: Container(
                  height: 42.0,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
