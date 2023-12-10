import 'package:flutter/material.dart';
import '../layout/bottomNav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('公告類別',textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          // profile UI 
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}