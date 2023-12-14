import 'package:flutter/material.dart';
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
    // 模擬從後端取得已訂閱的類別列表
    // 此處需要替換為從後端獲取數據的實際邏輯
    fetchSubscribedOptions();
  }

  // 模擬從後端取得已訂閱的類別列表的函數
  void fetchSubscribedOptions() {
    // 模擬已訂閱的類別列表
    subscribedOptions = ['0', '2', '4']; // 已訂閱的類別列表
    selectedSubscribedOptions = subscribedOptions.map(int.parse).toList();
  }

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
                ? const Text('沒有取得已訂閱的公告', style: TextStyle(color: Colors.red)) // 沒有取得已訂閱的公告時的提示
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
                    // 更新訂閱公告的邏輯，可以根據 selectedSubscribedOptions 進行相應的處理
                    // 將 selectedSubscribedOptions 送到後端
                    print('已選擇的訂閱項目：$selectedSubscribedOptions');
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

  // 將選中的訂閱項目送到後端的函數
  void updateSubscribedOptions() {
    print('已選擇的訂閱項目：$selectedSubscribedOptions');
    // 此處添加將選中的訂閱項目送到後端的邏輯
  }
}
