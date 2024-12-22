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
      home: DevelopersPage(),
    );
  }
}

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700), // Yellow background color
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for the header
        elevation: 0,

        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            "Developer's Page",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: const [
                DeveloperCard(name: 'Leonne Matthew Dayao'),
                DeveloperCard(name: 'Edrine Frances Esguerra'),
                DeveloperCard(name: 'Rayna Eliz Gulifardo'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;

  const DeveloperCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
