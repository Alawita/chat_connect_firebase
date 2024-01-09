import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        
      appBar: MyAppbar(appBarTitle: Text("chatbar")) ,
    );
  }
}