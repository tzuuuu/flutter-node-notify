import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    String account = accountController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String apiUrl = '';

    if (account.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請填寫完整資訊')),
      );
      return; 
    }

    if (kIsWeb || Platform.isWindows) {
      apiUrl = 'http://127.0.0.1:3000'; // Web
    } else {
      apiUrl = 'http://10.0.2.2:3000'; // Android 
    }

    // 註冊請求的 JSON 資料
    var data = {
      'Account': account,
      'Username': username,
      'Password': password,
    };
    
    print(data);
    final response = await http.post(
      Uri.parse('${apiUrl}/register'),
      headers: {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36'},
      body: data,
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text('註冊成功')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IndexScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('註冊失敗')),
      );
    }

    // 清空輸入欄位
    accountController.clear();
    usernameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: accountController,
              decoration: const InputDecoration(
                labelText: '帳號',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: '使用者名稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerUser(context); 
              },
              child: const Text('確認送出'),
            ),
          ],
        ),
      ),
    );
  }
}
