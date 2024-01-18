import 'package:chat_connect_app/app/core/extentions/build_conext_extinsion.dart';
import 'package:chat_connect_app/app/modules/navibar/domain/models/user_mode.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/helper/image_picker_bottom_sheet.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/models/message_details_model.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/providers/chat_provider.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/widgets/loading_effect.dart';
import 'package:chat_connect_app/app/modules/one_to_one_chat/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingBodyView extends ConsumerStatefulWidget {
  final UserModel selectedUser;

  const MessagingBodyView({
    super.key,
    required this.selectedUser,
  });

  @override
  ConsumerState<MessagingBodyView> createState() => _MessagingBodyViewState();
}

class _MessagingBodyViewState extends ConsumerState<MessagingBodyView>
    with PickAnImageBottomSheet {
  final _sendMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messagingRepo = ref.read(messagingProvider);
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Message>>(
            stream: messagingRepo.getAllMessages(
              senderId: FirebaseAuth.instance.currentUser!.uid,
              recieverID: widget.selectedUser.userID,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(
                    child: Text('Error fetching messages: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final messages = snapshot.data ?? [];
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    MessageBubble(message: messages[index]),
              );
            },
          ),
        ),
        const LoadingEffect(),
        _buildMessageInput(context, widget.selectedUser.userID, messagingRepo),
      ],
    );
  }

  Widget _buildMessageInput(
      BuildContext context, String userId, MessagingRepo messagingRepo) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () => showOptions(context,
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  receiverId: userId),
              icon: const Icon(Icons.add_a_photo)),
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type your message',
                hintStyle: context.textTheme.bodySmall,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await messagingRepo
                    .sendMessage(
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  recieverID: userId,
                  message: _sendMessageController.text,
                )
                    .whenComplete(() {
                  _sendMessageController.clear();
                });
              } catch (e) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.showSnackbar(
                    'Error sending message: $e',
                  );
                });
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
