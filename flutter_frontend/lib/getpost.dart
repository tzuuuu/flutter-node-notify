import 'dart:convert';
import 'package:http/http.dart' as http;

class PostFetcher {
  static const String baseUrl = 'https://itouch.cycu.edu.tw/home/mvc'; 
  static List<Map<String, dynamic>> datalog = []; // 新增 datalog 

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
        throw Exception('無法取得標題。錯誤: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('載入標題時發生錯誤: $error');
    }
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

        List<String> content = [];
        for (var item in responseData['content']) {
          content.add(item['TITLE'].toString());
        }
        return content;
      } else {
        throw Exception('無法取得內容。錯誤: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('載入內容時發生錯誤: $error');
    }
  }
}
