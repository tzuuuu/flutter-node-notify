import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../getpost.dart'; 

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> titles = [];                                             // 從 API 獲取的標題列表
  List<Map<String, dynamic>> contentlog = PostFetcher.getContentLog();  // 從 getpost 獲取的公告標題
  List<String> linkList = List.generate(10, (index) => 'Link $index');

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
      // print('Titles: $titles');
      handleButtonPress(0); // 預設行政公告
    } catch (e) {

      print('載入標題時發生錯誤: $e');
      List<String> defaultTitles = ["標題1", "標題2", "標題3", "標題4", "標題5", "標題6"];
      setState(() {
        titles = defaultTitles;
      });
    }
  }
  
  
  void _launchURL(String sn) async {
    if (sn != "" && sn.isNotEmpty) {
      // 公告的 URL
      String url = 'https://ann.cycu.edu.tw/aa/frontend/AnnItem.jsp?sn=$sn';

      if (await canLaunch(url)) {
        await launch(url); // 打開連結
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('無效的連結，請先選擇公告類別'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('無效的連結，請先選擇公告類別'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double adjustedHeight = MediaQuery.of(context).size.height;

    if( kIsWeb || Platform.isWindows) {
      adjustedHeight -= 250;
    } else {
      adjustedHeight -= 375;
    }
    
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
            height: adjustedHeight,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true, // 讓 ListView 根據內容大小動態收縮
              itemCount: linkList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(linkList[index]),
                  onTap: () {
                    if (contentlog.isNotEmpty) {
                      _launchURL(contentlog[index]['SN']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('無效的連結，請先選擇公告類別'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  void handleButtonPress(int index) async {
    try {
      // print('Pressed button $index');
      final postFetcher = PostFetcher();
      List<String> fetchedTitles = await postFetcher.fetchContent(index);
      
      setState(() { linkList = fetchedTitles; });
      // print('Titles: $linkList');

      } catch (error) {
        print('處理按鈕點擊時發生錯誤: $error');
      }
  } 

}
