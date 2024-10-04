import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
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
  static bool sendNotify = true;
  static Duration notificationDuration = const Duration(minutes: 1);
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
    if (!sendNotify) return;
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
    final int uniqueId = DateTime.now()
        .millisecondsSinceEpoch
        .remainder(100000); // Generate a unique ID using timestamp
    await _notificationsPlugin.show(
      uniqueId, // Notification ID
      azkarCategory
          .azkar.first.text, // Content text (limited to 410 characters)
      azkarCategory.category, // Category as subtitle
      platformDetails,
    );
  }

  // Schedule Azkar notification every hour
  static Future<void> scheduleAzkarNotification() async {
    if (!sendNotify) return;
    final int uniqueId = DateTime.now()
        .millisecondsSinceEpoch
        .remainder(100000); // Generate a unique ID using timestamp
    await _notificationsPlugin.zonedSchedule(
      uniqueId,
      'Azkar Reminder',
      'Fetching Azkar...',
      tz.TZDateTime.now(tz.local).add(notificationDuration),
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
    Timer.periodic(notificationDuration, (Timer timer) async {
      AzkarCategoryEntity randomAzkar = await fetchRandomAzkarWithLimit();
      await showAzkarNotification(randomAzkar); // Show the notification
    });
  }

  static Future<void> scheduleNotification() async {
    if (!sendNotify) return;
    final int alarmId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await AndroidAlarmManager.periodic(
      notificationDuration, alarmId, // Unique ID for the alarm
      () async {
        AzkarCategoryEntity azkar = await fetchRandomAzkarWithLimit();
        await showAzkarNotification(azkar);
      }, // The callback function
      wakeup: true, // Wake up the device if it is asleep
      exact: true, // Ensure it runs exactly every hour
      allowWhileIdle:
          true, // Allow the alarm to run while the device is in idle mode
      rescheduleOnReboot:
          true, // Reschedule the alarm if the device is rebooted
    );
  }

  // Update the notification duration
  void updateNotificationDuration(Duration newDuration) {
    notificationDuration = newDuration;
    // Reschedule the notification with the new duration
    scheduleNotification();
  }

// Set the sendNotify flag
  void setSendNotify(bool value) {
    sendNotify = value;
    if (sendNotify) {
      scheduleNotification(); // Reschedule if notifications are enabled
    }
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
