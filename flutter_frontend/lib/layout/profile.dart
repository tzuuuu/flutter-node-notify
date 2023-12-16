import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import '../layout/bottomNav.dart';
import '../profile_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getUsernameFromSharedPreferences();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('userAccount') != null;
    });
  }

  Future<void> getUsernameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('userName') ?? '';
      print('${username}');
    });
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
          body: ProfileContent(
            username: username,
          ),
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