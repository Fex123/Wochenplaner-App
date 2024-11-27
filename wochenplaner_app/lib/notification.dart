import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  final firebaseMassageing = FirebaseMessaging.instance;
  
  Future<void> initbaseMessage() async{
    await firebaseMassageing.requestPermission();
    final token = await firebaseMassageing.getToken();
    print(token);
  }
}
/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ScheduleNotification {
  String title;7
  String message;
  DateTime taskStartTime;

  ScheduleNotification({
    required this.title,
    required this.message,
    required this.taskStartTime,
  });

  Future<void> schedulePushNotification() async {
    // Initialize the timezone package
    tz.initializeTimeZones();

    // Initialize the local notification system
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // App icon for Android

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Schedule the notification
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'task_channel', // Channel ID
      'Task Notifications', // Channel name
      channelDescription: 'Notifications for upcoming tasks',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime notificationTime =
        tz.TZDateTime.from(taskStartTime.subtract(const Duration(minutes: 15)), tz.local);

    if (notificationTime.isAfter(DateTime.now())) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Notification ID
        title, // Notification title
        message, // Notification message
        notificationTime, // Scheduled time
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact, // Add the required parameter
        matchDateTimeComponents: DateTimeComponents.time, // Ensure it matches the exact time
      );
    } else {
      print('Task time is in the past. No notification scheduled.');
    }

    // Handle foreground notifications
    const AndroidNotificationDetails foregroundChannelSpecifics =
        AndroidNotificationDetails(
      'foreground_channel', // Channel ID
      'Foreground Notifications', // Channel name
      channelDescription: 'Notifications while the app is in the foreground',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails foregroundPlatformChannelSpecifics =
        NotificationDetails(android: foregroundChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      message, // Notification message
      foregroundPlatformChannelSpecifics,
    );
  }
}*/
