import 'package:flutter/material.dart';
import 'listing_data.dart';
import 'dart:async';
import 'src/icon_converter.dart';

class Listing extends StatelessWidget {
  final List<ListingData> listingData;

  const Listing({
    Key? key,
    required this.listingData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (1/1.35), // for resizing items properly
      children: <Widget>[
        for (var listing in listingData)
          _buildListing(listing: listing),
      ],
    );
  }

  Widget _buildListing({required ListingData listing}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                IconConverter.stringToIcon(listing.iconCode.toString()),
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            listing.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Location
          Text(
            listing.location,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          // Available hours
          Text(
            listing.time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          // Mode of payment
          Text(
            listing.payment,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            listing.description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
