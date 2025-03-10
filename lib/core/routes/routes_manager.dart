import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypothetical_app/core/routes/routes.dart';
import 'package:hypothetical_app/core/src/injection_container.dart';
import 'package:hypothetical_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hypothetical_app/features/auth/presentation/screens/login_screen.dart';
import 'package:hypothetical_app/features/auth/presentation/screens/signup_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

import '/core/manager/strings_manager.dart';

import '/core/manager/color_manager.dart';

class RoutesManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    late Widget screen;

    switch (settings.name) {
      case Routes.splashScreen:
        screen = const SplashScreen();
        break;
      case Routes.loginScreen:
        screen = BlocProvider(
          create: (context) =>
              AuthBloc(diInstance(), diInstance(), diInstance()),
          child: LoginScreen(),
        );
        break;
      case Routes.signUpScreen:
        screen = BlocProvider(
          create: (context) =>
              AuthBloc(diInstance(), diInstance(), diInstance()),
          child: const SignupScreen(),
        );
        break;
      default:
        screen = _undefinedRouteScreen();
        break;
    }

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child),
    );
  }

  static Widget _undefinedRouteScreen() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorsManager.redColor,
      body: const Center(
        child: Text(StringsManager.undefinedRoute),
      ),
    );
  }
}
