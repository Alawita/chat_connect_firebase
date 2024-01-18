import 'package:chat_connect_app/app/config/theme/my_colors.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/widgets/my_messages_widget.dart';
import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';

class OneToOneMessagingScreen extends StatelessWidget {
  const OneToOneMessagingScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.pastelBlue,
        title: Text(userModel.username.toString()),
      ),
      body: MessagingBodyView(selectedUser: userModel),
    );
  }
}
