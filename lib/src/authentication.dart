// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thomploy/login_page.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: StyledButton(
              onPressed: () {
                if (!loggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else { signOut(); }
              },
              child: !loggedIn ? const Text('Login') : const Text('Logout')),
        ),
        // This Visibility widget is for debugging only
        // i.e. to check the session username
        Visibility(
          visible: loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: Text(username),
          ),
        ),
      ],
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
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return null;
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
  return user;
}

Future<void> updateUsername({
    required String username,
  }) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.updateDisplayName(username);
    await user.reload();
    user = FirebaseAuth.instance.currentUser;
  }
}