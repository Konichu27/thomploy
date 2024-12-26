import 'package:flutter/material.dart';
import 'user_profile_page.dart';
import 'src/components.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'listing.dart';
import 'listing_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.amber),
                  hintText: 'Search for services',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            // Recent searches content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Consumer<ApplicationState>(
                  builder: (context, appState, _) {
                    List<ListingData> searchResults = _searchQuery.isEmpty
                        ? []
                        : appState.listingData
                            .where((listing) =>
                                listing.title.toLowerCase().contains(_searchQuery.toLowerCase()))
                            .toList();
                
                    return Listing(
                      listingData: searchResults,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
