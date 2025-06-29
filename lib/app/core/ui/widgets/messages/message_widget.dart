import 'package:flutter/material.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class MessageWidget extends StatelessWidget {
  final AppTheme theme;
  final String title;
  final String subtitle;
  final bool useSliverWidget;
  final EdgeInsetsGeometry padding;
  const MessageWidget({
    super.key,
    required this.theme,
    required this.title,
    this.subtitle = '',
    this.useSliverWidget = true,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return useSliverWidget
        ? sliverWidget(theme: theme, title: title, subtitle: subtitle)
        : normalWidget(theme: theme, title: title);
  }

  Widget sliverWidget({required AppTheme theme, required String title, String subtitle = ''}) {
    return SliverPadding(
      padding: padding,
      sliver: SliverToBoxAdapter(
        child: Center(
          child: content(theme: theme, title: title, subtitle: subtitle),
        ),
      ),
    );
  }

  Widget normalWidget({required AppTheme theme, required String title, String subtitle = ''}) {
    return Padding(
      padding: padding,
      child: Center(
        child: content(theme: theme, title: title, subtitle: subtitle),
      ),
    );
  }

  Widget content({required AppTheme theme, required String title, String subtitle = ''}) {
    return Column(
      spacing: 24.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/png/others/magikarp.png'),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.typography.poppins20px().copyWith(fontWeight: FontWeight.w600),
        ),
        Text(subtitle, textAlign: TextAlign.center, style: theme.typography.poppins14px()),
      ],
    );
  }
}
