import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  // don't run app until Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();
 
  // Provider class is responsible for managing the state of the application
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const ThomployApp()),
  ));
}

class ThomployApp extends StatelessWidget {
  const ThomployApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThomPloy',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFD700), // Bright Yellow
        primaryColorDark: const Color.fromARGB(255, 173, 147, 0), // Dark Yellow
        scaffoldBackgroundColor: const Color(0xFFFFD700),
      ),
      home: const HomePage(),
    );
  }
}