import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:softvence_agency_task/features/home/model/alarm_model.dart';

class HomeController extends GetxController {
  var switchValue = false.obs;

  var selectdate = ''.obs;
  var selecttime = ''.obs;

  var alarmList = <AlarmModel>[].obs;
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
     context: context, 
    );

    if (time == null) {
        Get.snackbar("Error", "Please picked the date");
      return;
    };

    final DateTime pickedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    
String formattedDate = DateFormat('EEE dd MMM yyyy').format(pickedDateTime);
String formattedTime = TimeOfDay(hour: pickedDateTime.hour, minute: pickedDateTime.minute).format(context);


selectdate.value = formattedDate;
selecttime.value = formattedTime;


alarmList.add(AlarmModel(date: formattedDate, time: formattedTime));
 
 
  }
}
