import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/routes.dart';
import 'package:todos/services/hive_service.dart';
import 'package:todos/utils/context_less_navigation.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      ref.read(hiveServiceProvider).getUserFirstOpenStatus().then((value) {
        if (value != null && value == true) {
          context.nav.pushNamedAndRemoveUntil(Routes.todos, (route) => false);
        } else {
          context.nav
              .pushNamedAndRemoveUntil(Routes.onboarding, (route) => false);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'TODO APP',
          style: AppTextStyle(context).title,
        ),
      ),
    );
  }
}
