import 'package:chat_connect_app/app/config/routes/my_named_routes.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatUserCard extends StatelessWidget {
  final UserModel user; // Assuming 'User' is your user model class

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
            // Assuming your User class has a property 'profileImageUrl'

            ),
        title: Text(user.username.toString()),
        subtitle: Text(user.email.toString()),
        // You can customize the ListTile as needed based on your User class properties
        // Add more details or actions as required
        onTap: () {
          context.pushNamed(MyNamedRoutes.chatroom, extra: user);
          // Handle onTap as needed
        },
      ),
    );
  }
}
