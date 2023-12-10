import 'package:flutter/material.dart';
import '../layout/bottomNav.dart';
import '../layout/notification.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      body: Column(
        children: [
          NotificationPage(),
        ],
      ),
    );
  }
}


