import 'package:flutter/material.dart';

class PokemonDetailsDescription extends StatelessWidget {
  final String description;

  const PokemonDetailsDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(description, style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
