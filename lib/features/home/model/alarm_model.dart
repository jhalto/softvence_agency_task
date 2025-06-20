import 'package:get/get.dart';

class AlarmModel {
  String date;
  String time;
  RxBool isOn;

  AlarmModel({
    required this.date,
    required this.time,
    bool isOn = true,
  }):isOn = isOn.obs;

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      date: json['date'],
      time: json['time'],
      isOn: json['isOn'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'isOn': isOn,
    };
  }
}