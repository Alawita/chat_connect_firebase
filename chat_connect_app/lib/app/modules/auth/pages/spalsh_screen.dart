import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/core/extentions/time_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: (){context.showSnackbar("Helllllo");}, child: Text("Hello")),
          Center(child: Text(context.translate.talal)),
        ],
      ),
    );
  }
}