import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'listing_data.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _userId = '';
  String get userId => _userId;
  String _username = '';
  String get username => _username;
  String? _email = '';
  String? get email => _email;

  List<ListingData> favorites = <ListingData>[];

  List<ListingData> _listingData = [];
  List<ListingData> get listingData => _listingData;
  StreamSubscription<QuerySnapshot>? _listingSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    _listingSubscription = FirebaseFirestore.instance
        .collection('listings')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _listingData = [];
      for (final document in snapshot.docs) {
        _listingData.add(
          ListingData(
            postId: document.id,
            name: document.data()['name'] as String,
            userId: document.data()['userId'] as String,
            iconCode: document.data()['icon'] as int,
            title: document.data()['title'] as String,
            location: document.data()['location'] as String,
            time: document.data()['time'] as String,
            payment: document.data()['payment'] as String,
            description: document.data()['description'] as String,
          ),
        );
      }
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        _loggedIn = true;
        _username = user.displayName ?? 'null';
        _userId = user.uid;
        _email = FirebaseAuth.instance.currentUser?.email;
        print('User is logged in as $_username');
      } else {
        _loggedIn = false;
        _username = '';
        _userId = '';
        _email = '';
        print('User is logged out');
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addListingToDatabase(Map<String, Object> listing) async {
    // add additional listing data
    listing.addAll({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': _username,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });

    return await FirebaseFirestore.instance.collection('listings').add(listing);
  }
  
  bool isFavorited(ListingData listingData) {
    return favorites.any((listing) => listing.postId == listingData.postId);
  }

  bool toggleFavorite(ListingData listingData) {
    final index = favorites.indexWhere((listing) => listing.postId == listingData.postId);
    bool isAdded = false; // If added, returns true; if removed, returns false

    if (index != -1) {
      favorites.removeAt(index);
      isAdded = false;
    } else {
      favorites.add(listingData);
      isAdded = true;
    }
    notifyListeners();
    return isAdded;
  }

  List<ListingData> getUserListing() {
    return _listingData.where((listing) => listing.userId == FirebaseAuth.instance.currentUser?.uid).toList();
  }

  Future<void> updateUserDetails(String displayName, String email) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(displayName);
      await user.updateEmail(email);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username': displayName,
        'email': email,
      });
      _username = displayName;
      _email = email;
      notifyListeners();
    }
  }
}