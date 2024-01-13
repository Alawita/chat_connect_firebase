// ignore_for_file: unused_element

import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/modules/auth/domain/helper/auth_validator.dart';
import 'package:chat_connect_app/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:chat_connect_app/app/modules/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAuthForm extends ConsumerStatefulWidget {
  const MyAuthForm({
    super.key,
    this.registerFormKey,
  });

  final GlobalKey<FormState>? registerFormKey;

  @override
  ConsumerState createState() => _MyAuthFormState();
}

class _MyAuthFormState extends ConsumerState<MyAuthForm> {
  final authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();

    userNameController.dispose();
    userNameFocus.dispose();
  }

  String getPasswordStrengthIndicator(String password) {
    bool hasLowerCase = false;
    bool hasUpperCase = false;
    bool hasSpecialChar = false;

    for (var char in password.runes) {
      var character = String.fromCharCode(char);
      if (character == character.toLowerCase() &&
          character != character.toUpperCase()) {
        hasLowerCase = true;
      } else if (character == character.toUpperCase() &&
          character != character.toLowerCase()) {
        hasUpperCase = true;
      } else if ('!@#\$%^&*()-_+=<>?/\\[]{}|'.contains(character)) {
        hasSpecialChar = true;
      }
    }

    if (password.length == 0) {
      return '';
    } else if (hasLowerCase && !hasUpperCase && !hasSpecialChar) {
      return 'Weak 😟';
    } else if (!hasLowerCase && !hasUpperCase && !hasSpecialChar) {
      return 'Weak 😟';
    } else if (hasLowerCase && hasUpperCase && !hasSpecialChar) {
      return 'Normal 😐';
    } else if (hasLowerCase && !hasUpperCase && hasSpecialChar) {
      return 'Normal 😐';
    } else if (hasLowerCase && hasUpperCase && hasSpecialChar) {
      return 'Strong 💪';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authFormContrller = ref.watch(authFormController);

    return SizedBox(
      child: Form(
        key: widget.registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextFormWidget(
                controller: emailController,
                obscureText: false,
                focusNode: emailFocusNode,
                validator: (input) {
                  return authValidators.emailValidator(input);
                },
                prefIcon: const Icon(Icons.email),
                labelText: context.translate.email,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  if (value != null) {
                    authFormContrller.setEmailField(value);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                controller: userNameController,
                obscureText: false,
                focusNode: userNameFocus,
                validator: (input) => authValidators.userNameValidator(input),
                prefIcon: const Icon(Icons.person),
                labelText: context.translate.username,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  if (value != null) {
                    authFormContrller.setUserNameField(value);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                controller: passwordController,
                obscureText:
                    authFormContrller.togglePassword == false ? true : false,
                focusNode: passwordFocusNode,
                validator: (input) => authValidators.passwordVlidator(input),
                prefIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  if (value != null) {
                    authFormContrller.setPasswordField(value);
                  }
                  return null;
                },
                togglePassword: () {
                  authFormContrller.togglePasswordIcon();
                },
                suffexIcon: Icon(
                  authFormContrller.togglePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
              Text(
                getPasswordStrengthIndicator(passwordController.text),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
