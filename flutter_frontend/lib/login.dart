import 'package:flutter/material.dart';
import '../layout/index.dart';
import '../register.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  Future<void> login(BuildContext context) async {
    final String account = accountController.text;
    final String password = passwordController.text;
    String apiUrl = '';

    if (kIsWeb) {
      apiUrl = 'http://127.0.0.1:3000'; // Web
    } else {
      apiUrl = 'http://10.0.2.2:3000'; // Android 
    }


    final response = await http.post(
      Uri.parse('${apiUrl}/login'), // 更改為你的 Node.js 伺服器位址
      headers: {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36'},
      body: {'account': account, 'password': password},
    );

    if (response.statusCode == 200) {
      print('login');
      String account = ''; // 假設從 response 中獲取使用者帳號
      String name = ''; // 假設從 response 中獲取使用者名稱

      // 儲存帳號和名稱至 SharedPreferences
      _saveUserDetails(account, name);     
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IndexScreen()),
      );
    } else {
      print(response.statusCode);
    }
  }

  _saveUserDetails(String account, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAccount', account);
    await prefs.setString('userName', name);
  }


 @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: accountController,
            decoration: const InputDecoration(
              labelText: '帳號',
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: '密碼',
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => login(context),
            child: const Text('登入'),
          ),
          const SizedBox(height: 10.0), // 添加間距
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
            },
            child: const Text('註冊'),
          ),
        ],
      ),
    );
  }
}

