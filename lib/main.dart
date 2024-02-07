import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/config/app_constants.dart';
import 'package:todos/firebase_options.dart';
import 'package:todos/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Enable offline persistence for iOS and Android
  firestore.settings = const Settings(persistenceEnabled: true);
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appSettingsBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // XD Design Sizes
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      builder: (context, child) {
        return const MaterialApp(
          title: 'TODO APP',
          onGenerateRoute: generatedRoutes,
          initialRoute: Routes.splash,
        );
      },
    );
  }
}
