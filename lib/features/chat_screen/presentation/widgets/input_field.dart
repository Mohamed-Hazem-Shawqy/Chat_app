import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:firebaseproject/features/auth/presentation/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController messageController = TextEditingController();
  final messages = FirebaseFirestore.instance.collection("messages");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[200], borderRadius: BorderRadius.circular(30)),
      child: CustomTextForm(
        controller: messageController,
        label: "",
        scure: false,
        colors: Colors.green,
        suff: IconButton(
            onPressed: () async {
              messages.add({
                "content": messageController.text,
                "time": DateTime.now(),
                "sender": FirebaseAuth.instance.currentUser!
                    .email, // return the email address for currently signin user
                "userName": BlocProvider.of<AuthCubit>(context).userNameUp.text
              });
              messageController.text = "";
            },
            icon: const Icon(Icons.send)),
      ),
    );
  }
}
