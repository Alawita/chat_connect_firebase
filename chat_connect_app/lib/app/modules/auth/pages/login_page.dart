import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/config/routes/router.dart';
import 'package:chat_connect_app/app/config/theme/my_colors.dart';
import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:chat_connect_app/app/modules/auth/widgets/my_sign_in.dart';
import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    final fieldValues = ref.watch(authFormController);
    final checkIfAuth = ref.watch(checkIfAuthinticated);

    return Scaffold(
      appBar: MyAppbar(
        appBarTitle: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthSignInForm(registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  authProvider
                      .login(
                          email: fieldValues.email,
                          userName: fieldValues.userName,
                          password: fieldValues.password)
                      .then((value) {
                    if (value == true) {
                      context.goNamed(MyNamedRoutes.home);
                    }
                  });
                }
              },
              child: Text(context.translate.login)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("you dont have an account?"),
              TextButton(
                  onPressed: () {
                    context.goNamed(MyNamedRoutes.register);
                  },
                  child: Text(
                    context.translate.register,
                    style: const TextStyle(color: Colors.lightBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () {
                authProvider.signInWithGoogle().then((value) async {
                  if (value == true) {
                    context.goNamed(MyNamedRoutes.home);
                  }
                  ;
                });
              },
              child: Text(context.translate.googleLogin)),
        ],
      ),
    );
  }
}
