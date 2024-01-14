import 'dart:ffi';

import 'package:chat_connect_app/app/modules/one_to_one_chat/domain/models/message_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class MessagingRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      {required String senderId,
      required String recieverID,
      required String message}) async {
    try {
      final chatRoomId = _getChatRoomId(senderId, recieverID);

      DocumentReference messageRef = _firebaseFirestore
          .collection("chat_room")
          .doc(chatRoomId)
          .collection("Messages")
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      Message chatMessage = Message(
          messageId: const Uuid().v4(),
          recieverId: recieverID,
          senderId: senderId,
          message: message,
          timeStamp: DateTime.now());

      await messageRef.set(chatMessage.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  _getChatRoomId(String senderId, String recieverID) {
    return senderId.hashCode <= recieverID.hashCode
        ? "$senderId-$recieverID"
        : "$recieverID-$senderId";
  }

  Stream<List<Message>> getAllMessages(
      {required String senderId, required String recieverID}) {
    final chatroomId = _getChatRoomId(senderId, recieverID);
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        _firebaseFirestore
            .collection("chat_room")
            .doc(chatroomId)
            .collection("Messages")
            .orderBy("timeStamp", descending: true)
            .snapshots();

    return snapshot.map((quarySnapshot) => quarySnapshot.docs.map((document) {
          final data = document.data();

          DateTime datetime = data["timeStamp"] is int
              ? DateTime.fromMillisecondsSinceEpoch(data["timeStamp"])
              : data['timeStamp'] as DateTime;

          return Message(
              messageId: document.id,
              recieverId: data['recieverId'],
              senderId: data['senderId'],
              message: data['message'],
              timeStamp: datetime);
        }).toList());
  }
}
