import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thomploy/listing_data.dart';

class ChatPage extends StatefulWidget {
  final String listingId;
  final String ownerId;
  final String username;

  const ChatPage({super.key,
                  required this.listingId,
                  required this.ownerId,
                  required this.username
                });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String chatId;

  @override
  void initState() {
    super.initState();
    _checkAndCreateChat();
  }

  void _checkAndCreateChat() async {
    chatId = _generateChatId(widget.ownerId, _auth.currentUser!.uid);
    final chatDoc = await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
    if (!chatDoc.exists) {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'participants': [widget.ownerId, _auth.currentUser!.uid],
        'listingId': widget.listingId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  String _generateChatId(String ownerId, String userId) {
    return ownerId.compareTo(userId) < 0 ? '$ownerId\_$userId' : '$userId\_$ownerId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat with ${widget.username}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat Messages Section
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var isMe = message['senderId'] == _auth.currentUser?.uid;

                    return ListTile(
                      title: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message['text'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Message Input Section
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                      ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('chats')
                            .doc(chatId).collection('messages')
                            .add({
                          'text': _controller.text,
                          'senderId': _auth.currentUser?.uid,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
