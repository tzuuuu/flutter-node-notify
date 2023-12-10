import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginRequest() async {
    String url = 'YOUR_BACKEND_API_URL'; // 將此替換為你的後端API端點

    // 使用http post向後端發送帳號密碼
    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    // 檢查回傳的狀態碼和處理回傳的資料
    if (response.statusCode == 200) {
      // 處理登入成功的情況
      print('登入成功');
      // 可以導航到其他頁面或執行相應的操作
    } else {
      // 處理登入失敗的情況
      print('登入失敗');
      // 可以顯示錯誤訊息給使用者或執行其他適當的處理
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
