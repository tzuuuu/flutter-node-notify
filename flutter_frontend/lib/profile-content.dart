import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logout.dart';

class ProfileContent extends StatefulWidget {
  final String username;

  const ProfileContent({
    required this.username,
  });

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  List<String> subscribedOptions = []; // 已訂閱的類別
  List<int> availableOptions = [0, 1, 2, 3, 4, 5];
  List<int> selectedSubscribedOptions = []; // 已選擇的已訂閱類別

    @override
  void initState() {
    super.initState();
    fetchSubscribedOptions();
  }

  // loading 訂閱項目
  Future<void> fetchSubscribedOptions() async {
    String apiUrl = '';
    if (kIsWeb || Platform.isWindows) {
      apiUrl = 'http://127.0.0.1:3000'; // Web
    } else {
      apiUrl = 'http://10.0.2.2:3000'; // Android 
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userAccount = prefs.getString('userAccount');

      final response = await http.post(
        Uri.parse('$apiUrl/get-subscriptions'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36',
          'Content-Type': 'application/json',
        },
        body: json.encode({'user_account': userAccount}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        print('Response data: $responseData'); // check~

        if (responseData.containsKey('categoryIds') && responseData['categoryIds'] is List) {
          setState(() {
            selectedSubscribedOptions = (responseData['categoryIds'] as List)
              .where((category) {
                try {
                  int.parse(category.toString()) - 1;
                  return true; // 如果成功轉換為整數，表示有訂閱
                } catch (e) {
                  return false; // 無法轉換，視為沒有訂閱，排除該值
                }
              })
              .map<int>((category) => int.parse(category.toString()) - 1).toList();
          });
        } else {
          throw Exception('Received data is not in the expected format (contains "categoryIds" key and a List<dynamic>)');
        }
      } else {
        throw Exception('Failed to fetch subscribed options. Status code: ${response.statusCode}');
      }

    } catch (error) {
      print('Error fetching subscribed options: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('獲取訂閱選項時出現錯誤: $error'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
  
  // 根據數字類別返回對應的文字
  String getOptionText(int option) {
    switch (option) {
      case 0:
        return '行政公告';
      case 1:
        return '徵才公告';
      case 2:
        return '校內徵才';
      case 3:
        return '校外來文';
      case 4:
        return '實習/就業';
      case 5:
        return '活動預告';
      default:
        return '未知';
    }
  }

  // update 訂閱項目
  void updateSubscribedOptions() async {
    String apiUrl = '';
    if (kIsWeb || Platform.isWindows) {
      apiUrl = 'http://127.0.0.1:3000'; // Web
    } else {
      apiUrl = 'http://10.0.2.2:3000'; // Android 
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userAccount = prefs.getString('userAccount');
      print(userAccount);
      final List<String> selectedOptions = selectedSubscribedOptions.map((option) => (option + 1).toString()).toList();

      final response = await http.post(
        Uri.parse('$apiUrl/update-subscriptions'), // 假設此為後端端點
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_account': userAccount,
          'newSubscriptions': selectedOptions,
        }),
      );

      if (response.statusCode == 200) {
        print('訂閱更新成功');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text('訂閱更新成功'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('更新訂閱失敗: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('更新訂閱失敗: ${response.statusCode}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('發生錯誤: $error');
    }
  }

  // UI 從這開始
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '訂閱類別',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '您好，${widget.username}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: availableOptions.isEmpty
                ? const Text('沒有取得已訂閱的公告', style: TextStyle(color: Colors.red)) 
                : ListView.builder(
                    itemCount: availableOptions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = availableOptions[index];
                      final optionText = getOptionText(option);
                      return CheckboxListTile(
                        title: Text(optionText),
                        value: selectedSubscribedOptions.contains(option),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                selectedSubscribedOptions.add(option);
                              } else {
                                selectedSubscribedOptions.remove(option);
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('已選擇的訂閱項目：$selectedSubscribedOptions');
                    updateSubscribedOptions();
                  },
                  child: const Text('更新訂閱公告'),
                ),
                const SizedBox(width: 16), 
                 ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogoutScreen(logoutCallback: () {})),
                    );
                  },
                  child: const Text('登出'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
