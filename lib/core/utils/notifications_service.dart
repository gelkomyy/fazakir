import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
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

  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    Random.secure().nextInt(100000).toString(),
    'High Importance Notifications',
    importance: Importance.high,
  );

  static Future<void> requestNotificationsPermission() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

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

    await requestNotificationsPermission();
    await requestAutoStartPermission();
  }

  // Show the notification for the Azkar content
  @pragma('vm:entry-point')
  static Future<void> showAzkarNotification(
      AzkarCategoryEntity azkarCategory) async {
    if (!sendNotify) return;

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Reminder for Azkar',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _notificationsPlugin.show(
      330, // Notification ID
      azkarCategory
          .azkar.first.text, // Content text (limited to 410 characters)
      azkarCategory.category, // Category as subtitle
      notificationDetails,
    );
  }

  // Schedule Azkar notification every hour
  @pragma('vm:entry-point')
  static Future<void> scheduleAzkarNotification() async {
    if (!sendNotify) return;
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Reminder for Azkar',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _notificationsPlugin.zonedSchedule(
      330,
      'Azkar Reminder',
      'Fetching Azkar...',
      tz.TZDateTime.now(tz.local).add(notificationDuration),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Every hour
    );

    // Fetch the azkar in the background using a callback
    Timer.periodic(
      notificationDuration,
      (Timer timer) async => await callbackShowAzkarNotification(),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> scheduleNotification() async {
    if (!sendNotify) return;
    await AndroidAlarmManager.cancel(330);

    await _notificationsPlugin.cancelAll();

    var result = await AndroidAlarmManager.periodic(
      notificationDuration, 330, // Unique ID for the alarm
      callbackShowAzkarNotification, // The callback function
      wakeup: true, // Wake up the device if it is asleep
      exact: true, // Ensure it runs exactly every hour
      allowWhileIdle:
          true, // Allow the alarm to run while the device is in idle mode
      rescheduleOnReboot:
          true, // Reschedule the alarm if the device is rebooted
    );
    if (!result) {
      dev.log('AndroidAlarmManager.periodic: false result');
      await scheduleAzkarNotification();
      dev.log('The scheduleAzkarNotification done.');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> callbackShowAzkarNotification() async {
    AzkarCategoryEntity randomAzkar = await fetchRandomAzkarWithLimit();
    await showAzkarNotification(randomAzkar);
  }

  // Update the notification duration
  static void updateNotificationDuration(Duration newDuration) {
    notificationDuration = newDuration;
    // Reschedule the notification with the new duration
    scheduleNotification();
  }

// Set the sendNotify flag
  static void setSendNotify(bool value) {
    sendNotify = value;
    if (sendNotify) {
      scheduleNotification(); // Reschedule if notifications are enabled
    }
  }

  static Future<void> requestAutoStartPermission() async {
    const intent = AndroidIntent(
      action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
      data: 'package:com.fazakir.elkomy',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
  }
}

Future<AzkarCategoryEntity> fetchRandomAzkarWithLimit() async {
  AzkarCategoryEntity? azkarCategory;
  bool validLength = false;
  while (!validLength) {
    azkarCategory = await getIt<AzkarRepoImpl>()
        .getRandomAzkarCategory(); // Fetch random AzkarCategoryEntity
    if (azkarCategory.azkar.first.text.length <= 120) {
      validLength = true; // Found contentText with valid length
    }
  }

  return azkarCategory!;
}
