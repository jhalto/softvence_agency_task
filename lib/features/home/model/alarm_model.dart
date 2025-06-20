import 'package:get/get.dart';

class AlarmModel {
  String date;
  String time;
  RxBool isOn;

  AlarmModel({
    required this.date,
    required this.time,
    RxBool? isOn,
  }) : isOn = isOn ?? RxBool(true);

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      date: json['date'],
      time: json['time'],
      isOn: RxBool(true), // default ON when loaded
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
    };
  }
}
