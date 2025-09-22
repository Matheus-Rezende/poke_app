import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_type_badge.dart';

class PokemonWeaknesses extends StatelessWidget {
  final List<String> typeWeaknesses;

  const PokemonWeaknesses({super.key, required this.typeWeaknesses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.0,
        children: [
          Text('Fraquezas', style: Theme.of(context).textTheme.titleMedium),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 24.0,
            ),
            children: typeWeaknesses
                .map(
                  (type) => PokemonTypeBadge(
                    type: type,
                    isContentCentralized: true,
                    //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
