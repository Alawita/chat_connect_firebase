// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String messageId;
  final String recieverId;
  final String senderId;
  final String message;
  final DateTime timeStamp;
  Message({
    required this.messageId,
    required this.recieverId,
    required this.senderId,
    required this.message,
    required this.timeStamp,
  });

  Message copyWith({
    String? messageId,
    String? recieverId,
    String? senderId,
    String? message,
    DateTime? timeStamp,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      recieverId: recieverId ?? this.recieverId,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'recieverId': recieverId,
      'senderId': senderId,
      'message': message,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'] as String,
      recieverId: map['recieverId'] as String,
      senderId: map['senderId'] as String,
      message: map['message'] as String,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(messageId: $messageId, recieverId: $recieverId, senderId: $senderId, message: $message, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId &&
        other.recieverId == recieverId &&
        other.senderId == senderId &&
        other.message == message &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        recieverId.hashCode ^
        senderId.hashCode ^
        message.hashCode ^
        timeStamp.hashCode;
  }
}
