import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/features/auth/presentation/Views/login.dart';
import 'package:firebaseproject/features/chat_screen/presentation/widgets/chat_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat page"),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();

                  Navigator.pushReplacementNamed(context, LoginPage.id);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const ChatScreenBody());
  }
}
