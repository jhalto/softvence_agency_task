import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // ignore: use_build_context_synchronously
    ).format(context);

    selectdate.value = formattedDate;
    selecttime.value = formattedTime;
    final newAlarm = AlarmModel(date: formattedDate, time: formattedTime);
    alarmList.add(newAlarm);
    
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> savedAlarms =
      prefs.getStringList('alarms') ?? <String>[];

  savedAlarms.add(jsonEncode(newAlarm.toJson()));
  await prefs.setStringList('alarms', savedAlarms);
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

    // ignore: unused_local_variable
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
  }

  @override
  void onInit() {
    askNotificationPermission();
    loadAlarmsFromStorage();
    init();

    super.onInit();
  }

  Future<void> loadAlarmsFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final savedAlarms = prefs.getStringList('alarms') ?? [];

  alarmList.value = savedAlarms.map((alarmJson) {
    final alarmMap = jsonDecode(alarmJson);
    return AlarmModel(
      date: alarmMap['date'],
      time: alarmMap['time'],
      isOn: RxBool(true),
    );
  }).toList();
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
