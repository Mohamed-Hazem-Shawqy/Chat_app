import 'package:firebaseproject/features/auth/presentation/Views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit/auth_cubit.dart';
import '../widgets/text_form.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static String id = "SignUpPage";

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> username = GlobalKey();
  GlobalKey<FormState> password = GlobalKey();
  GlobalKey<FormState> email = GlobalKey();

  RegExp invalid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("SignUpSuccess")));
            Navigator.pushReplacementNamed(context, LoginPage.id);
          } else if (state is SignUpFailuer) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwcBGZjMaRlp8ucEPZpjsQF5lb1zMOUZWCIw&s'),
              CustomTextForm(
                controller: BlocProvider.of<AuthCubit>(context).emailUp,
                colors:
                    BlocProvider.of<AuthCubit>(context).emailUp.text.isNotEmpty
                        ? Colors.green
                        : Colors.black,
                label: 'Email',
                scure: false,
                valid: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!invalid.hasMatch(
                      BlocProvider.of<AuthCubit>(context).emailUp.text)) {
                    return 'invalid email';
                  }
                  return null;
                },
                keys: email,
              ),
              CustomTextForm(
                controller: BlocProvider.of<AuthCubit>(context).userNameUp,
                colors: BlocProvider.of<AuthCubit>(context)
                        .userNameUp
                        .text
                        .isNotEmpty
                    ? Colors.green
                    : Colors.black,
                label: 'Username',
                scure: false,
                valid: (val) {
                  if (val!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                keys: username,
              ),
              CustomTextForm(
                controller: BlocProvider.of<AuthCubit>(context).passUp,
                colors:
                    BlocProvider.of<AuthCubit>(context).passUp.text.isNotEmpty
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
              state is SignUpLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (email.currentState!.validate() &&
                            username.currentState!.validate() &&
                            password.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).signUp();
                        }
                      },
                      child: const Text('Sign up')),
              Row(
                children: [
                  const Text("I have an account already "),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginPage.id);
                      },
                      child: const Text("Login"))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
