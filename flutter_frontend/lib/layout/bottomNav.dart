import 'package:flutter/material.dart';
import 'package:notification_system/getpost.dart';
import '../layout/index.dart';
import '../layout/profile.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '個人頁面'),
      ],
      currentIndex: 0,
      onTap: (index) {
        PostFetcher.clearContentLog();
        if (index == 0) {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const IndexScreen()),
          );
        } else  {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
      },
    );
  }
}
