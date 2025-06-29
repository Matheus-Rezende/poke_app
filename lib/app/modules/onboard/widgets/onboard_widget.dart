import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class OnboardWidget extends StatelessWidget {
  final String pathCoach1;
  final double widthCoach1;
  final String pathCoach2;
  final String title;
  final String subtitle;
  const OnboardWidget({
    super.key,
    required this.pathCoach1,
    this.widthCoach1 = 100,
    this.pathCoach2 = '',
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    final sizeOf = MediaQuery.sizeOf(context);

    return Column(
      children: [
        pathCoach2.isNotEmpty
            ? Row(
                spacing: 0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      pathCoach1,
                      filterQuality: FilterQuality.high,
                      height: sizeOf.height * 0.2,
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      pathCoach2,
                      filterQuality: FilterQuality.high,
                      height: sizeOf.height * 0.2,
                    ),
                  ),
                ],
              )
            : Image.asset(pathCoach1, filterQuality: FilterQuality.high, width: sizeOf.width * 0.7),
        SizedBox(height: sizeOf.height * 0.01),
        Text(
          title,
          style: appTheme.typography.poppins26px().copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: sizeOf.height * 0.01),
        Text(
          subtitle,
          style: appTheme.typography.poppins14px().copyWith(color: appTheme.colors.greyColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
