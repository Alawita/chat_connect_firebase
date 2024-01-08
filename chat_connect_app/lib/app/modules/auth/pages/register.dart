import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/config/theme/my_colors.dart';
import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:chat_connect_app/app/modules/auth/widgets/my_auth_form.dart';
import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    final fieldValues = ref.watch(authFormController);
    
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
          MyAuthForm(registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
					ElevatedButton(
onPressed: (){
  authProvider.register(email: fieldValues.email, userName: fieldValues.userName, password: fieldValues.password);
},
				child: Text(context.translate.register)						
),Row(mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("Already rehistered?"), TextButton(onPressed: (){context.pushNamed(MyNamedRoutes.login);}, child: Text("Sign in here!", style: TextStyle(color: Colors.lightBlue),))
  ],
),

 const SizedBox(
            height: 12,
          ),
TextButton(
onPressed: () {
  authProvider.signInWithGoogle();
},
child: Text(context.translate.googleLogin)
),
				],
      ),
    );
  }
}
