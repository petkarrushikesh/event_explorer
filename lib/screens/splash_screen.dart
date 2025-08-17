import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'event_list_screen.dart';
import 'package:event_explorer/screens/auth/login_screen.dart';
import 'package:event_explorer/screens/auth/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds, then check auth state
    Timer(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User is logged in → go to Event List
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EventListScreen()),
        );
      } else {
        // User is not logged in → go to Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event, color: Colors.white, size: 80),
            SizedBox(height: 20),
            Text(
              "Event Explorer",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
