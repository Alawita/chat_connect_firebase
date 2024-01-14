import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              authProvider.signOut().then((value) {
                if (value == true) {
                  context.goNamed(MyNamedRoutes.login);
                }
              });
            },
            child: Text("Logout")),
        Center(
            child: Container(
          color: Colors.green,
          height: 300,
          width: 300,
        )),
      ],
    );
  }
}
