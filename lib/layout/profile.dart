import 'package:flutter/material.dart';
import '../layout/bottomNav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('個人頁面'),
      ),
      // Your profile page UI components here
      bottomNavigationBar: const BottomNav(),
      body: Column(
        children: [
          // Your UI components for displaying notifications and categories here
          // You can implement the notification list and category bar
        ],
      ),
    );
  }
}