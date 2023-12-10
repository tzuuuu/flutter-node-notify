import 'package:flutter/material.dart';
import '../layout/bottomNav.dart';
import '../layout/notification.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('公告類別',textAlign: TextAlign.center,),
      ),
      body: Column(
        children: [
          NotificationPage(),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}


