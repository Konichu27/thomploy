import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_state.dart';
import 'chat_page.dart';
import 'login_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _) {
          if (!appState.loggedIn) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Log in to view your chats'),
              ),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where('participants', arrayContains: appState.userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ));
              }

              var chats = snapshot.data!.docs;

              if (chats.isEmpty) {
                return const Center(
                  child: Text('No chats available'),
                );
              }

              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  // Get the chat data
                  var chat = chats[index];
                  var participants = chat['participants'];
                  var otherUserId = participants.firstWhere((id) => id != appState.userId, orElse: () => '');

                  // If the other user ID is empty, return an error message
                  if (otherUserId.isEmpty) {
                    return const ListTile(
                      title: Text('Error loading chat.'),
                    );
                  }

                  // Return the chat list tile
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
                    builder: (context, userSnapshot) {
                      if (!userSnapshot.hasData) {
                        return ListTile(
                          shape: _buildBottomBorder(),
                          title: const Text('Loading...'),
                        );
                      }

                      var userData = userSnapshot.data?.data() as Map<String, dynamic>?;
                      if (userData == null) {
                        return ListTile(
                          shape: _buildBottomBorder(),
                          title: const Text('Error loading user data.'),
                        );
                      }

                      var otherUserName = userData['username'];

                      return ListTile(
                        //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        tileColor: Colors.white,
                        shape: _buildBottomBorder(),
                        title: Text('$otherUserName', style: const TextStyle(fontSize: 16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                ownerId: otherUserId,
                                listingId: chat.id,
                                username: otherUserName,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Border _buildBottomBorder() {
    return Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.3),
                            width: 1.0,
                            ),
                          );
  }
}
