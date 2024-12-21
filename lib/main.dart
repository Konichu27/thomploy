import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_page.dart';

void main() async {
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
    //return MaterialApp.router(
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThomPloy',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFD700), // Bright Yellow
        scaffoldBackgroundColor: const Color(0xFFFFD700),
      ),
      home: HomePage(),
      //routerConfig: _router, // new
    );
  }
}