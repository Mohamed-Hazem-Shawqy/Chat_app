import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String content;
  final DateTime time;
  final String sender;
  final String userName;

  ChatMessage({
    required this.content,
    required this.time,
    required this.sender,
    required this.userName,
  });

  factory ChatMessage.fromJson(json) {
    return ChatMessage(
        content: json["content"],
        time: (json["time"] as Timestamp).toDate(),
        sender: json["sender"],
        userName: json["userName"]);
  }

   String getFormattedTime() {
    return DateFormat('hh:mm').format(time); // Convert to 12 hour
  }
}
