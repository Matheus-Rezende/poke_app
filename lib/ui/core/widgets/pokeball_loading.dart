import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/utils/assets/app_assets.dart';

class PokeballLoading extends StatefulWidget {
  final bool isSliverWidget;
  const PokeballLoading({super.key, this.isSliverWidget = false});

  @override
  State<PokeballLoading> createState() => _PokeballLoadingState();
}

class _PokeballLoadingState extends State<PokeballLoading> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationLoading;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);

    _animationLoading = CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSliverWidget ? sliverWidget() : commonWidget();
  }

  Widget sliverWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: RotationTransition(
            turns: _animationLoading,
            child: SvgPicture.asset(AppAssets.general.pokeball, height: 40.0),
          ),
        ),
      ),
    );
  }

  Widget commonWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: RotationTransition(
          turns: _animationLoading,
          child: SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0),
        ),
      ),
    );
  }
}
