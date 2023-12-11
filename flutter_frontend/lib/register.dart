import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                // 在這裡處理註冊按鈕的操作
                // String account = accountController.text;
                // String username = usernameController.text;
                // String password = passwordController.text;

                
                // 清空輸入欄位
                accountController.clear();
                usernameController.clear();
                passwordController.clear();
              },
              child: const Text('確認送出'),
            ),
          ],
        ),
      ),
    );
  }
}