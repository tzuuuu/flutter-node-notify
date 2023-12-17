import 'package:flutter/material.dart';
import 'bottom-nav.dart';
import 'notification.dart';

class IndexScreen extends StatelessWidget {
  IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('公告類別', textAlign: TextAlign.center),
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
