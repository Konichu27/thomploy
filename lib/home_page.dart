import 'package:flutter/material.dart';
import 'package:thomploy/explore_page.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;

import 'edit_profile_page.dart';
import 'user_profile_page.dart';
import 'src/components.dart';
import 'search_page.dart';
import 'dev_page.dart';
import 'chat_list_page.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'src/authentication.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Image(
                height: 48,
                image: AssetImage('assets/launcher/logo.png'),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.developer_mode),
                    title: const Text('Developers Page'),
                    onTap: () {
                      // Navigate to Developers Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DevelopersPage()),
                      );
                    },
                  ),
                  if (appState.loggedIn) ...[
                    ListTile(
                      leading: const Icon(Icons.chat),
                      title: const Text('Chats'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatListPage()),
                        );
                      },
                    ),
                  ],
                  Consumer<ApplicationState>( // auth tile
                    builder: (context, appState, _) => AuthListTile(
                      loggedIn: appState.loggedIn,
                      signOut: () {
                        FirebaseAuth.instance.signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Successfully logged out')),
                        );
                      },
                      username: appState.username,
                    ),
                  ),
                ],
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
                  icon: Icon(Icons.home, size: 30),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.search, size: 30),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline, size: 30),
                  label: 'Profile',
                ),
              ],
            ),
            body: <Widget>[
              ExplorePage(),
              SearchPage(),
              Consumer<ApplicationState>( // user profile page with auth
                builder: (context, appState, _) => UserProfilePage(
                  loggedIn: appState.loggedIn,
                  username: appState.username,
                  email: appState.email,
                ),
              ),
            ][_selectedTab],
          ),
        );
      },
    );
  }
}