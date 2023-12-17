import 'package:flutter/material.dart';
import 'package:notification_system/getpost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart'; 

class LogoutScreen extends StatelessWidget {
  final VoidCallback logoutCallback;

  const LogoutScreen({
    required this.logoutCallback,
  });

  @override
  Widget build(BuildContext context) {
    clearUserData(context);
    PostFetcher.clearContentLog();

    return Scaffold(
      appBar: AppBar(
        title: const Text('登出'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('你已登出'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => IndexScreen()),
                );
              },
              child: const Text('返回首頁'),
            ),
          ],
        ),
      ),
    );
  }

  // 清除使用者資料
  void clearUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }
}
