import 'package:firebaseproject/constant.dart';
import 'package:firebaseproject/features/chat_screen/data/chats_model.dart';
import 'package:flutter/material.dart';

class MessageSendShape extends StatelessWidget {
  const MessageSendShape({
    super.key,
    required this.message,
  });
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "${message.time.toString().substring(0, 11)} at ${message.getFormattedTime()}"),
            const SizedBox(height: 10),
            Text(message.content),
          ],
        ),
      ),
    );
  }
}
