import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/models/globals.dart';
import 'package:ecommerce_app/providers/settings.dart';
import 'package:ecommerce_app/screens/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void setErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          ':-( Something went wrong!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Text(
          '\n${details.exception}',
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Contact shivanshukgupta on linkedin for support\n',
          textAlign: TextAlign.center,
        ),
      ],
    ));
  };
}

void main() async {
  setErrorWidget();
  WidgetsFlutterBinding.ensureInitialized();
  await settings.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkMode,
      builder: (context, value, child) {
        value ??=
            (MediaQuery.of(context).platformBrightness == Brightness.dark);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hustle Stay',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              brightness: value ? Brightness.dark : Brightness.light,
              seedColor: Colors.purple,
            ),
            textTheme: GoogleFonts.quicksandTextTheme().apply(
              bodyColor: value ? Colors.white : Colors.black,
              displayColor: value ? Colors.white : Colors.black,
            ),
          ),
          home: const AuthPage(),
        );
      },
    );
  }
}
