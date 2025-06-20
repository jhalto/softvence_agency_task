import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:softvence_agency_task/features/home/model/alarm_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class HomeController extends GetxController {
  var switchValue = false.obs;

  var selectdate = ''.obs;
  var selecttime = ''.obs;

  var alarmList = <AlarmModel>[].obs;
  Future<void> askNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) {
      Get.snackbar("Error", "Please picked the date");
      return;
    }

    final TimeOfDay? time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      // ignore: use_build_context_synchronously
      context: context,
    );

    if (time == null) {
      Get.snackbar("Error", "Please picked the date");
      return;
    }

    final DateTime pickedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    String formattedDate = DateFormat('EEE dd MMM yyyy').format(pickedDateTime);
    String formattedTime = TimeOfDay(
      hour: pickedDateTime.hour,
      minute: pickedDateTime.minute,
    ).format(context);

    selectdate.value = formattedDate;
    selecttime.value = formattedTime;

    alarmList.add(AlarmModel(date: formattedDate, time: formattedTime));
  }

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    tz.setLocalLocation(getLocation('America/Toronto'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);
    await notificationsPlugin.initialize(initializationSettings);

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
  }

  @override
  void onInit() {
    askNotificationPermission();
    init();

    super.onInit();
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          channelDescription: 'Instant notification channel',
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: false, // <-- Add this
          playSound: true,
          enableVibration: true,
        ),
      ),
    );
  }
}
