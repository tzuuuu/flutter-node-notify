import 'package:flutter/material.dart';
import 'index.dart';
import 'post-notify.dart'; 

void main() async {
  runApp(MyApp());
  await Future.delayed(Duration(seconds: 5));
  print('send notify');
  await PostNotify.sendNotification(); // 發送通知
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexScreen(),
    );
  }
}
