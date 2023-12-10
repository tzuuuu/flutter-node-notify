import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginRequest() async {
    String url = 'YOUR_BACKEND_API_URL'; 

    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      print('登入成功');
    } else {
      print('登入失敗');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '帳號',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // 執行登入請求的功能
                loginRequest();
              },
              child: Text('登入'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // 導航到註冊頁面，假設註冊頁面為 RegisterPage()
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('沒有帳號？點此註冊'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('註冊'),
      ),
      body: Center(
        child: Text('註冊頁面內容'),
      ),
    );
  }
}
