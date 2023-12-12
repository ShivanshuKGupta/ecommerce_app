import 'package:ecommerce_app/auth/auth_form.dart';
import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return Scaffold(
            body: Center(
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to',
                      style: textTheme(context)
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PP Shop',
                      style: textTheme(context).titleLarge!.copyWith(
                            color: colorScheme(context).primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AuthForm(
                        onSubmit: (email, password) async {
                          await auth.signInWithEmailAndPassword(
                              email: email, password: password);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
