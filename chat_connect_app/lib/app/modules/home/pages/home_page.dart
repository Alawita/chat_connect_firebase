import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatelessWidget {
   MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        
      appBar: MyAppbar(appBarTitle: Text(context.translate.chat)) ,
      body: Center(child: Text(context.translate.email),),
    );
  }
}