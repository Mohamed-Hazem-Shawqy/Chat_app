import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:firebaseproject/features/auth/presentation/widgets/text_form.dart';
import 'package:firebaseproject/features/chat_screen/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> username = GlobalKey();
  GlobalKey<FormState> password = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
               ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("SigninSuccess")));
              Navigator.pushReplacementNamed(context, ChatPage.id);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please verifiy your email")));
            }
          } else if (state is SigninFailuer) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          } else if (state is GoogleSigninSuccess) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("GoogleSigninSuccess")));
            Navigator.pushReplacementNamed(context, ChatPage.id);
          } else if (state is GoogleSigninFailuer) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("GoogleSigninFailuer")));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Column(
                children: [
                  Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwcBGZjMaRlp8ucEPZpjsQF5lb1zMOUZWCIw&s'),
                  CustomTextForm(
                    label: 'email',
                    pre: const Icon(Icons.person),
                    scure: false,
                    keys: username,
                    valid: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: BlocProvider.of<AuthCubit>(context).email,
                    colors: BlocProvider.of<AuthCubit>(context)
                            .email
                            .text
                            .isNotEmpty
                        ? Colors.green
                        : Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomTextForm(
                    controller: BlocProvider.of<AuthCubit>(context).pass,
                    colors:
                        BlocProvider.of<AuthCubit>(context).pass.text.isNotEmpty
                            ? Colors.green
                            : Colors.black,
                    label: 'Password',
                    scure: BlocProvider.of<AuthCubit>(context).visible,
                    suff: IconButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).visible =
                              !BlocProvider.of<AuthCubit>(context).visible;
                          setState(() {});
                        },
                        icon: BlocProvider.of<AuthCubit>(context).visible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    valid: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    keys: password,
                  ),
                  const SizedBox(height: 20),
                  state is SigninLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (username.currentState!.validate() &&
                                password.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).signIn();
                            }
                          },
                          child: const Text('Login')),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Don't have an account"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Signup.id);
                          },
                          child: const Text('Sign up'))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85),
                    child: state is GoogleSigninLoading
                        ? const CircularProgressIndicator()
                        : MaterialButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .signInWithGoogle();
                            },
                            child: Row(children: [
                              const Text("SignIn with Google  "),
                              SizedBox(
                                height: 30,
                                width: 60,
                                child: Image.asset("assets/google.jpeg"),
                              )
                            ]),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
