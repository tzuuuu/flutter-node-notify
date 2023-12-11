import 'package:flutter/material.dart';
import '../layout/index.dart'; // 引入 index.dart

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => const IndexScreen()), // 導航回 index.dart
                );
              },
              child: const Text('返回首頁'),
            ),
          ],
        ),
      ),
    );
  }
}
