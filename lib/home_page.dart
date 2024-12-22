import 'package:flutter/material.dart';
import 'package:thomploy/explore_search_pages.dart';
import 'test/EditProfileScreen.dart';
import 'test/UserProfileScreen.dart';
import 'components.dart';
import 'search_page.dart';

void main() {
  runApp(const ThomployApp());
}

class ThomployApp extends StatelessWidget {
  const ThomployApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thomploy',
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFFFC107),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'thomploy',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedTab,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          ExploreSearchPages(),
          SearchPage(),
          UserProfileScreen(),
              /*// White header container with centered logo
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: const Center(
                  child: Text(
                    'thomploy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Bottom Navigation Bar
              buildBottomNavigationBar(context, _selectedTab, (index) {
                setState(() {
                  _selectedTab = index;
                });
              }),*/
        ][_selectedTab],
      ),
    );
  }
}
