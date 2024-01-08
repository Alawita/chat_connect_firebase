import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar(
      {super.key, required this.appBarTitle, this.showLeading = false});

  final Text appBarTitle;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showLeading,
      title: appBarTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}