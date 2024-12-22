import 'package:flutter/material.dart';
import 'EditProfileScreen.dart';
import 'UserProfileScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserProfileScreen(),
      routes: {
        '/editProfile': (context) => const EditProfileScreen(),
      },
    );
  }
}
