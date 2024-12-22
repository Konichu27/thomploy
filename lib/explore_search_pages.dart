import 'package:flutter/material.dart';
import 'components.dart';

class ExploreSearchPages extends StatefulWidget {
  @override
  _ExploreSearchPagesState createState() => _ExploreSearchPagesState();
}

class _ExploreSearchPagesState extends State<ExploreSearchPages> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.black),
            ),
            tabs: [
              Tab(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    //color: _tabController.index == 0 ? Colors.black : Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    //color: _tabController.index == 1 ? Colors.black : Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            buildExploreContent(),
            buildFavoritesContent(),
          ],
        ),
      ),
    );
  }
}
