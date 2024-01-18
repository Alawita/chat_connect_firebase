import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/core/services/notifications_service.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/provider/chat_provider.dart';
import 'package:chat_connect_app/app/modules/navibar/widgets/chat_user_card.dart';
import 'package:chat_connect_app/shared/myapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomeScreen extends ConsumerStatefulWidget {
  const MyHomeScreen({super.key});
  @override
  _MyHomeScreen createState() => _MyHomeScreen();
}

class _MyHomeScreen extends ConsumerState<MyHomeScreen> {
  final notificationService = NotificationSetup();

  @override
  void initState() {
    super.initState();
    notificationService.registerNotification();
    notificationService.configLocalNotification();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final chatUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: MyAppbar(appBarTitle: Text(context.translate.chat)),
      body: chatUsers.when(data: (List<UserModel> data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final user = data[index];
            return ChatUserCard(user: user);
          },
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text("error"));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
