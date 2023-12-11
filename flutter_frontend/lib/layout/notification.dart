import 'package:flutter/material.dart';
import '../getpost.dart'; 

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> titles = []; // 從 API 獲取的標題列表

  @override
  void initState() {
    super.initState();
    _loadTitles();
  }

  void _loadTitles() async {
    try {
      final postFetcher = PostFetcher();
      List<String> postTitles = await postFetcher.getTitles();

      setState(() {
        titles = postTitles; // 更新標題列表
      });
      print('Titles: $titles');
    } catch (e) {
      print('載入標題時發生錯誤: $e');
    }
  }
  List<String> linkList = List.generate(10, (index) => 'Link $index');


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              titles.length,
              (index) => ElevatedButton(
                onPressed: () {
                  // botton on click
                  handleButtonPress(index);
                },
                child: Text(titles[index]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('公告清單', textAlign: TextAlign.center),
          const SizedBox(height: 10),
          // listview
          Container(
            height: MediaQuery.of(context).size.height - 400,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true, // 讓 ListView 根據內容大小動態收縮
              itemCount: linkList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(linkList[index]),
                  onTap: () {
                    // on click event
                  },
                );
              },
            )
          ),
        ],
      ),
    );
  }


  void handleButtonPress(int index) async {
    try {
      print('Pressed button $index');
      final postFetcher = PostFetcher();
      List<String> fetchedTitles = await postFetcher.fetchContent(index);
      
      setState(() {
        linkList = fetchedTitles;
        _loadTitles();
      });
      print('Titles: $linkList');
      } catch (error) {
        print('處理按鈕點擊時發生錯誤: $error');
      }
  } 

}
