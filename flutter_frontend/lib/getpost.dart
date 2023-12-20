import 'dart:convert';
import 'package:http/http.dart' as http;

class PostFetcher {
  static const String baseUrl = 'https://itouch.cycu.edu.tw/home/mvc'; 
  static List<Map<String, dynamic>> datalog = [];    // 公告類別 
  static List<Map<String, dynamic>> contentlog = []; // 公告清單

  // 建立 datalog
  static void createDatalog(Map<String, dynamic> responseData) {
    final itemList = responseData['ann_title'] as List;

    for (var index = 0; index < itemList.length; index++) {
      var item = itemList[index];
      datalog.add({
        'id': item['id'],
        'title': item['name'],
      });
      print('$index - ${item['id']} - ${item['name']}');
    }
  }

  Future<List<String>> getTitles() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ann.Model.jsp?method=title'),
        headers: {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36'},
        body: jsonEncode({'perPage': '50'}), 
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // 建立 datalog
        createDatalog(responseData);

        List<String> titles = [];
        for (var item in responseData['ann_title']) {
          titles.add(item['name'].toString());
        }
        return titles;
      } else {
        print('無法取得標題。錯誤: ${response.reasonPhrase}');
        List<String> defaultTitles = List.generate(6, (index) => '標題${index + 1}');
        return defaultTitles;
      }
    } catch (error) {
      print('載入標題時發生錯誤: $error');
      List<String> defaultTitlesOnError  = List.generate(6, (index) => '標題${index + 1}');
      return defaultTitlesOnError ;      
    }
  }

  static void createContentlog(Map<String, dynamic> responseData) {
    clearContentLog();
    final contentList = responseData['content'] as List;

    for (var item in contentList) {
      contentlog.add({
        'title': item['TITLE'],
        'SN': item['SN'], // 存取 'SN' 資料
      });
      print(contentlog);
    }
  }

  // 給 notification.dart 呼叫公告清單
  static List<Map<String, dynamic>> getContentLog() {
    return contentlog;
  }

  // 登入/出時清空公告
  static void clearContentLog() {
    contentlog.clear();
  }


  Future<List<String>> fetchContent(int inputId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ann.Model.jsp?method=query'),
        headers: {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36'},
        body: jsonEncode({'sn_type': datalog[inputId]['id'], 'perPage': '50'}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        createContentlog(responseData);

        List<String> content = [];
        for (var item in responseData['content']) {
          content.add(item['TITLE'].toString());
        }
        return content;
      } else {
        print('無法取得內容。錯誤: ${response.reasonPhrase}');
        List<String> defaultContent = List.generate(5, (index) => 'list${index + 1}');
        return defaultContent;        
      }
    } catch (error) {
      print('載入內容時發生錯誤: $error');
      List<String> defaultContentOnError = List.generate(5, (index) => 'list${index + 1}');
      return defaultContentOnError;
    }
  }
}
