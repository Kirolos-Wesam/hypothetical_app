import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hypothetical_app/core/extensions/durations.dart';
import '../../../../manager/assets_manager.dart';
import '../../../../routes/routes.dart';
import '/core/manager/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  void _navigateToNextScreen() =>
      Navigator.pushReplacementNamed(context, Routes.layoutScreen);

  void _startDelay() {
    _timer = Timer(const Duration(seconds: Values.splashDurationSeconds), () {
      _navigateToNextScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationLimiter(
          child: AnimationConfiguration.staggeredList(
            position: 0,
            child: FadeInAnimation(
              curve: Curves.bounceInOut,
              duration: Values.splashDurationSeconds.seconds,
              child: Image.asset(
                AssetsManager.appIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
