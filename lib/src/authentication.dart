// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thomploy/login_page.dart';
import 'package:flutter/services.dart';

class AuthListTile extends StatelessWidget {
  const AuthListTile({
    super.key,
    required this.loggedIn,
    required this.signOut,
    required this.username, // for testing login sessions only
  });

  final bool loggedIn;
  final void Function() signOut;
  final String username; // for testing login sessions only

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: !loggedIn ? const Icon(Icons.login) : const Icon(Icons.logout),
      title: !loggedIn ? const Text('Log In') : const Text('Log Out'), // should read logout in actual sessions
      onTap: () {
        if (!loggedIn) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          Navigator.pop(context);
          FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully logged out'),
            ),
          );
        }
      },
    );
  }
}

Future<User?> signIn({
    required String email,
    required String password,
  }) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on Exception catch (e) {
    return null;
  }
}

Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}

Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
  User? user = await signUpWithEmailPassword(
    email: email,
    password: password,
    );
  if (user != null) {
    await user.updateDisplayName(username);
  }
  await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
    'userId': user.uid,
    'username': username,
    'email': email,
    'chats': FieldValue.arrayUnion([]),
  });
  return user;
}