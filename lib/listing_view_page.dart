import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'listing_data.dart';
import 'app_state.dart';
import 'chat_page.dart';
import 'login_page.dart';

class ListingViewPage extends StatelessWidget {
  final ListingData listing;

  const ListingViewPage({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 173, 147, 0),
      ),
      body: Column(
        children: [
          // Yellow Content Section
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Square Container
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            IconData(listing.iconCode, fontFamily: 'MaterialIcons'),
                            size: 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Service Details
                    Text(
                      listing.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      listing.location,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      listing.time,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      listing.payment,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      listing.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Created by: ${listing.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // White Footer
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Heart Icon Button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Consumer<ApplicationState>(
                    builder: (context, appState, _) => IconButton(
                        icon: Icon(
                        appState.isFavorited(listing)
                          ? Icons.favorite
                          : Icons.favorite_border,
                        ),
                      onPressed: () {
                        bool isAdded = appState.toggleFavorite(listing);
                        String snackBarMessage = isAdded
                            ? 'Added to favorites'
                            : 'Removed from favorites';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          content: Text(snackBarMessage),
                          duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Chat Button
                Consumer<ApplicationState>(
                  builder: (context, appState, _) {
                    if (listing.userId != appState.userId) {
                      return Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            // If user is not logged in, show a dialog.
                            // Else, navigate to the chat page.
                            if (!appState.loggedIn) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Log in required'),
                                    content: const Text('You need to log in to start a chat.'),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context).primaryColorDark,
                                        ),
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context).primaryColorDark,
                                        ),
                                        child: const Text('Log in'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    listingId: listing.postId,
                                    ownerId: listing.userId,
                                    username: listing.name,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(width: 10),
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {Navigator.pop(context);},
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
