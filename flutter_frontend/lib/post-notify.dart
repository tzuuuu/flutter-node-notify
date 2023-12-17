import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PostNotify {
  static Future<void> sendNotification() async {
    // 初始化 FlutterLocalNotificationsPlugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // 初始化 Android 設定
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // 初始化並設定初始設定
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // 初始化時區庫
    tz.initializeTimeZones();

    // 設定時區
    var location = tz.getLocation('Asia/Taipei');

    // 設定通知的內容
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // 設定通知發送時間
    var scheduledTime = tz.TZDateTime.now(location);
    print(scheduledTime);
    // 發送通知
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // 通知的識別符號
      '歡迎光臨！', // 通知標題
      '來看看有甚麼新通知吧。', // 通知內容
      scheduledTime, // 設定的通知發送時間
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    // 通知已發送
    print('已經發送了一則通知！');
  }
}
