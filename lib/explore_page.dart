import 'package:flutter/material.dart';
import 'src/components.dart';
import 'app_state.dart';
import 'listing_data.dart';
import 'listing.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          TabBar(
            padding: const EdgeInsets.only(top: 8.0),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.black),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black.withOpacity(0.6),
            splashFactory: NoSplash.splashFactory,
            labelStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(child: Text('Explore'),),
              Tab(child: Text('Favorites'),),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => buildExploreContent(appState.listingData),
                ),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => buildFavoritesContent(appState.favorites),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildExploreContent(List<ListingData> listingEntries) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Featured Card
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/building.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Agile Assistance,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Roaring Reliable Results.',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Service Cards Row with texts outside
        Expanded(
          child: Listing(
            listingData: listingEntries,
          ),
        ),
      ],
    ),
  );
}

Widget buildFavoritesContent(List<ListingData> favorites) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: favorites.isEmpty
      ? const Center(
          child: Text(
            'You have no favorites.',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        )
      : Listing(
        listingData: favorites,
    ),
  );
}
