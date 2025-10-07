import 'package:flutter/material.dart';
import 'package:poke_app/utils/assets/app_assets.dart';

class PokemonMessage extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool useSliverWidget;
  const PokemonMessage({
    super.key,
    required this.title,
    this.subtitle = '',
    this.useSliverWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return useSliverWidget
        ? sliverWidget(title: title, subtitle: subtitle, context: context)
        : normalWidget(title: title, subtitle: subtitle, context: context);
  }

  Widget sliverWidget({
    required String title,
    String subtitle = '',
    required BuildContext context,
  }) {
    return SliverToBoxAdapter(
      child: Center(
        child: content(title: title, subtitle: subtitle, context: context),
      ),
    );
  }

  Widget normalWidget({
    required String title,
    String subtitle = '',
    required BuildContext context,
  }) {
    return Center(
      child: content(title: title, subtitle: subtitle, context: context),
    );
  }

  Widget content({required String title, String subtitle = '', required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        spacing: 16.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.general.magikarp),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
