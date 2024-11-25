import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/features/auth/presentation/Views/signup.dart';
import 'package:firebaseproject/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:firebaseproject/features/welcome/presentation/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/Views/login.dart';
import 'features/chat_screen/presentation/views/chat_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chat());
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  User? isSigenIn;
  @override
  void initState() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      isSigenIn = user;
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              LoginPage.id: (context) => const LoginPage(),
              Signup.id: (context) => const Signup(),
              WelocmePage.id: (context) => const WelocmePage(),
              ChatPage.id: (context) => const ChatPage(),
            },
            initialRoute: WelocmePage.id));
  }
}
