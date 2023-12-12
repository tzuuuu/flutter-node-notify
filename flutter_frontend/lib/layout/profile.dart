import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notification_system/login.dart';
import '../getpost.dart';
import '../layout/bottomNav.dart';
import '../logout.dart'; 


class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('userAccount') != null;
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 清除使用者資料
    PostFetcher.clearContentLog();

    // 導航到 logout.dart
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                '個人檔案',
                textAlign: TextAlign.center,
              ),
            ),
            body: ProfileContent(logout), // 將 logout 方法傳遞到 ProfileContent
            bottomNavigationBar: const BottomNav(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                '登入',
                textAlign: TextAlign.center,
              ),
            ),
            body: LoginScreen(),
          );
  }
}

class ProfileContent extends StatelessWidget {
  final VoidCallback logoutCallback; // 回調函數

  const ProfileContent(this.logoutCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 使用者名稱的個人檔案
        Text('使用者名稱'),

        // 訂閱類別
        Text('訂閱類別'),

        // 所有的公告類別並加上核取方塊
        Expanded(
          child: ListView(
            children: [
              CheckboxListTile(
                title: const Text('公告類別 1'),
                value: false, // 此處需使用實際的狀態值
                onChanged: (bool? value) {
                  // 更新核取方塊的狀態
                },
              ),
              // 其他公告類別的核取方塊...
            ],
          ),
        ),

        // 更新訂閱公告按鈕
        ElevatedButton(
          onPressed: () {
            // 更新訂閱公告的邏輯
          },
          child: const Text('更新訂閱公告'),
        ),

        // 登出按鈕
        ElevatedButton(
          onPressed: logoutCallback, // 點擊時呼叫 logout 方法
          child: const Text('登出'),
        ),
      ],
    );
  }
}
