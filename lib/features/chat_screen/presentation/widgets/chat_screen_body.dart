import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/features/chat_screen/data/chats_model.dart';
import 'package:firebaseproject/features/chat_screen/presentation/widgets/input_field.dart';
import 'package:firebaseproject/features/chat_screen/presentation/widgets/messagerecieve_shape.dart';
import 'package:firebaseproject/features/chat_screen/presentation/widgets/messagesend_shape.dart';
import 'package:flutter/material.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({super.key});

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final messages = FirebaseFirestore.instance.collection("messages");
  List<ChatMessage> listChatMessage = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 5000.0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: messages.orderBy("time", descending: false).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                listChatMessage.clear();
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  listChatMessage
                      .add(ChatMessage.fromJson(snapshot.data!.docs[i]));
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                }
                return Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: listChatMessage.length,
                      itemBuilder: (context, index) {
                        return listChatMessage[index].sender ==
                                FirebaseAuth.instance.currentUser!.email
                            ? MessageSendShape(message: listChatMessage[index])
                            : MessageRecieveShape(
                                message: listChatMessage[index]);
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Somtehing went wrong please try again!");
              }
            }),
        const InputField(),
      ],
    );
  }
}
