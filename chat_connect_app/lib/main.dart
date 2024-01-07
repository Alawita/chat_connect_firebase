import 'package:chat_connect_app/app/config/routes/router.dart';
import 'package:chat_connect_app/app/config/theme/my_themes.dart';
import 'package:chat_connect_app/firebase_options.dart';
import 'package:chat_connect_app/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //rootNavigatorKey.currentState!.context.pushNamed("name");
    return MaterialApp.router(
      theme: MyTheme.lightTheme,
      
      routerConfig: AppRouter.router,
    );
  }
}


