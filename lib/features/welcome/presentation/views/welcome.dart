import 'package:firebaseproject/features/auth/presentation/Views/login.dart';
import 'package:flutter/material.dart';

class WelocmePage extends StatelessWidget {
  const WelocmePage({super.key});
  static String id = "WelcomePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Spacer(flex: 2),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.asset(
              "assets/welcome.png",
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(flex: 2),
          Text(
            "Welcome to\n chat app",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text("Talk to\n any person",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(.5),
              )),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginPage.id);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueGrey,
                  size: 21,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
