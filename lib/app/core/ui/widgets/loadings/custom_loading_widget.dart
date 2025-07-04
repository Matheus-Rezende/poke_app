import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoadingWidget extends StatefulWidget {
  final bool isSliverWidget;
  const CustomLoadingWidget({super.key, this.isSliverWidget = true});

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget> with TickerProviderStateMixin {
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
            child: SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0),
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
