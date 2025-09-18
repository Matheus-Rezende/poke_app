import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/core/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redirect();
    });
    super.initState();
  }

  Future<void> _redirect() async {
    if (mounted) {
      context.go(Routes.menu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.darkblue.withValues(alpha: 0.5),
            AppColors.darkblue.withValues(alpha: 1.5),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.0,
        children: [
          SvgPicture.asset('assets/icons/svg/pokeball_icon.svg', height: 200.0),
          SvgPicture.asset('assets/images/svg/logos/pokemon_logo.svg', height: 140.0),
        ],
      ),
    );
  }
}
