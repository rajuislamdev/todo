import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todos/screens/onboarding_screen.dart';
import 'package:todos/screens/splash_screen.dart';
import 'package:todos/screens/todo_screen.dart';
import 'package:todos/screens/todo_view_update_screen.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const todos = '/todos';
  static const todoViewUpdate = '/todoViewUpdate';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    //core
    case Routes.splash:
      child = const SplashScreen();

      break;
    case Routes.onboarding:
      child = const OnboardingScreen();

      break;
    case Routes.todos:
      child = const TodoScreen();
      break;
    case Routes.todoViewUpdate:
      child = const TodoViewUpdateScreen();

      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  debugPrint('Route: ${settings.name}');

  return PageTransition(
    child: child,
    type: PageTransitionType.theme,
    settings: settings,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}
