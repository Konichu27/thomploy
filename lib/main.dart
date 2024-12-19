import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  // don't run app until Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();

  // Provider class is responsible for managing the state of the application
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const ThomployApp()),
  ));
}

class ThomployApp extends StatelessWidget {
  const ThomployApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    //return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thomploy',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFD700), // Bright Yellow
        scaffoldBackgroundColor: const Color(0xFFFFD700),
      ),
      //home: LoginPage(),
      routerConfig: _router, // new
    );

  }

  
}

final loginStyle = EmailFormStyle(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
);

final loginTheme = ThemeData(
  primaryColor: const Color(0xFFFFD700), // Bright Yellow
  scaffoldBackgroundColor: const Color(0xFFFFD700),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.bold),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

        //emailFormStyle: customEmailFormStyle,

// GoRouter for routing pages in the app,
// particularly Firebase-related ones
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'log-in',
          builder: (context, state) => Theme(
            data: loginTheme,
            child: SignInScreen(
              // Actions for authentication
              actions: [
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                })),
              ],
              // Button styling

              styles: <FirebaseUIStyle>{
                loginStyle,
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome Back'
                        : 'Welcome to Thomploy',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
              footerBuilder: (context, action) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);