import 'package:flutter/material.dart';
import 'test/EditProfileScreen.dart';
import 'search_page.dart';

Widget buildTabButton(String title, int index, int selectedTab, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedTab == index ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: selectedTab == index ? Colors.black : Colors.black.withOpacity(0.6),
          ),
        ),
      ),
    ),
  );
}

/*Widget buildBottomNavigationBar(BuildContext context, int selectedTab, ValueChanged<int> onTabSelected) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarIcon(Icons.home, 0, selectedTab, onTabSelected),
          buildNavBarIcon(Icons.search, null, selectedTab, onTabSelected, const SearchPage()),
          buildNavBarIcon(Icons.person_outline, null, selectedTab, onTabSelected, const EditProfileScreen()),
        ],
      ),
    ),
  );
}

Widget buildNavBarIcon(IconData icon, int? index, int selectedTab, ValueChanged<int> onTabSelected, [Widget? page]) {
  return IconButton(
    icon: Icon(icon, color: index == selectedTab ? Colors.amber : Colors.grey),
    onPressed: () {
      if (index != null) {
        onTabSelected(index);
      } else if (page != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    },
  );
}*/

Widget buildExploreContent() {
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
              Positioned(
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildServiceCard(
              icon: Icons.print,
              iconColor: Colors.amber.shade700,
              title: 'ABC Printing',
              location: 'Asturias St., Dapitan',
              hours: '8:00 am - 11:00 pm',
              payment: 'GCash and Cash',
            ),
            const SizedBox(width: 16), // Spacing between cards
            buildServiceCard(
              icon: Icons.videocam,
              iconColor: Colors.purple,
              title: 'XYZ Edits',
              location: 'Online Service',
              hours: '8:00 am - 11:00 pm',
              payment: 'GCash and Maya',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildFavoritesContent() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Service Cards Row with texts outside
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildServiceCard(
              icon: Icons.print,
              iconColor: Colors.amber.shade700,
              title: 'ABC Printing',
              location: 'Asturias St., Dapitan',
              hours: '8:00 am - 11:00 pm',
              payment: 'GCash and Cash',
            ),
            const SizedBox(width: 16), // Spacing between cards
            buildServiceCard(
              icon: Icons.videocam,
              iconColor: Colors.purple,
              title: 'XYZ Edits',
              location: 'Online Service',
              hours: '8:00 am - 11:00 pm',
              payment: 'GCash and Maya',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildServiceCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String location,
  required String hours,
  required String payment,
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Card
        Container(
          height: 140, // Fixed height for uniformity
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Texts below card
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          location,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hours,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        Text(
          payment,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

AppBar buildAppBar() {
  return AppBar(
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
  );
}