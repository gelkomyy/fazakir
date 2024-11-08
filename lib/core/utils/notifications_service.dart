import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  static bool sendNotify = true;
  static Duration notificationDuration = const Duration(minutes: 5);
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
    SharedPreferences.getInstance().then((prefs) {
      sendNotify = prefs.getBool('send_notify') ?? true;
      final savedDuration = prefs.getInt('notify_saved_duration');
      final savedIsMinutes = prefs.getBool('notify_is_minutes') ?? true;

      if (savedDuration != null) {
        if (savedIsMinutes) {
          notificationDuration = Duration(minutes: savedDuration);
        } else {
          notificationDuration = Duration(hours: savedDuration);
        }
      }
    });
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_stat_tazkeer_icon');

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
      color: AppColors.primaryColor, // Set the desired background color
      colorized: true, // Enable colorization for Android 12+
      styleInformation: BigTextStyleInformation(
        azkarCategory.azkar.first.text,
        contentTitle: azkarCategory.category,
        htmlFormatBigText: true,
        htmlFormatContentTitle: true,
      ),
      importance: Importance.max,
      priority: Priority.high,
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
    final int notificationId = Random.secure().nextInt(100000);
    await _notificationsPlugin.show(
      notificationId, // Notification ID
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
      color: AppColors.primaryColor, // Set the desired background color
      colorized: true, // Enable colorization for Android 12+
      importance: Importance.max,
      priority: Priority.high,
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
    final int notificationId = Random.secure().nextInt(100000);
    await _notificationsPlugin.zonedSchedule(
      notificationId,
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
    await AndroidAlarmManager.cancel(330);
    await _notificationsPlugin.cancelAll();
    if (!sendNotify) return;
    var result = await AndroidAlarmManager.periodic(
      notificationDuration, 330, // Unique ID for the alarm
      callbackShowAzkarNotification,
      wakeup: true,
      exact: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
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
    if (newDuration == notificationDuration) return;
    notificationDuration = newDuration;
    scheduleNotification();
  }

// Set the sendNotify flag
  static void setSendNotify(bool value) {
    if (value == sendNotify) return;
    sendNotify = value;
    scheduleNotification();
  }

  static Future<void> requestAutoStartPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if permission has already been requested and granted
    bool isPermissionRequested =
        prefs.getBool('autoStartPermissionRequested') ?? false;

    if (!isPermissionRequested) {
      const intent = AndroidIntent(
        action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
        data: 'package:com.fazakir.elkomy',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();

      // Store the fact that permission was requested
      prefs.setBool('autoStartPermissionRequested', true);
    }
  }
}

Future<AzkarCategoryEntity> fetchRandomAzkarWithLimit() async {
  AzkarCategoryEntity? azkarCategory;
  bool validLength = false;
  while (!validLength) {
    azkarCategory = await AzkarRepoImpl()
        .getRandomAzkarCategory(); // Fetch random AzkarCategoryEntity
    if (azkarCategory.azkar.first.text.length <= 410) {
      validLength = true; // Found contentText with valid length
    }
  }

  return azkarCategory!;
}
