import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700), // Yellow background color
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100), // Circular white background
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 36,
              ),
              children: [
                TextSpan(
                  text: 'thom',
                  style: TextStyle(
                    color: Color(0xFFDAA520), // Gold-like color
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'ploy',
                  style: TextStyle(
                    color: Color(0xFFDAA520), // Gold-like color
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
