import 'dart:async';

import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotification() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  // Show the notification for the Azkar content
  static Future<void> showAzkarNotification(
      AzkarCategoryEntity azkarCategory) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'azkar_channel', // Channel ID
      'Azkar Notifications', // Channel name
      channelDescription: 'Reminder for Azkar',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      0, // Notification ID
      azkarCategory
          .azkar.first.text, // Content text (limited to 410 characters)
      azkarCategory.category, // Category as subtitle
      platformDetails,
    );
  }

  // Schedule Azkar notification every hour
  static Future<void> scheduleHourlyAzkarNotification() async {
    await _notificationsPlugin.zonedSchedule(
      0,
      'Azkar Reminder',
      'Fetching Azkar...',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'azkar_channel',
          'Azkar Notifications',
          channelDescription: 'Reminder for Azkar',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Every hour
    );

    // Fetch the azkar in the background using a callback
    Timer.periodic(const Duration(hours: 1), (Timer timer) async {
      AzkarCategoryEntity randomAzkar = await fetchRandomAzkarWithLimit();
      await showAzkarNotification(randomAzkar); // Show the notification
    });
  }
}

Future<AzkarCategoryEntity> fetchRandomAzkarWithLimit() async {
  AzkarCategoryEntity? azkarCategory;
  bool validLength = false;

  while (!validLength) {
    azkarCategory = await getIt<AzkarRepoImpl>()
        .getRandomAzkarCategory(); // Fetch random AzkarCategoryEntity
    if (azkarCategory.azkar.first.text.length <= 410) {
      validLength = true; // Found contentText with valid length
    }
  }

  return azkarCategory!;
}
