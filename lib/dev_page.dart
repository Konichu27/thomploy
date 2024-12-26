import 'package:flutter/material.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD700), // Yellow background color
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Image(
            height: 48,
            image: AssetImage('assets/launcher/logo.png'),
          )
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
                DeveloperCard(
                  name: 'Leonne Matthew Dayao',
                  imageURL: 'assets/leonne.jpg',
                ),
                DeveloperCard(
                  name: 'Edrine Frances Esguerra',
                  imageURL: 'assets/edrine.jpg',
                ),
                DeveloperCard(
                  name: 'Rayna Eliz Gulifardo',
                  imageURL: 'assets/rayna.jpg',
                ),
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
  final String imageURL;

  const DeveloperCard({
    Key? key,
    required this.name,
    required this.imageURL,
  }) : super(key: key);

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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: AssetImage(imageURL))
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
