import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Animation<double> animation;
  const CustomLoadingWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: RotationTransition(
            turns: animation,
            child: SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0),
          ),
        ),
      ),
    );
  }
}
