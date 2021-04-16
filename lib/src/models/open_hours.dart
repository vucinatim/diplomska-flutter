import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OpenHours extends Equatable {
  const OpenHours(this.opensAt, this.closesAt);

  final TimeOfDay? opensAt;
  final TimeOfDay? closesAt;

  @override
  List<Object?> get props => <Object?>[opensAt, closesAt];

  OpenHours.fromJson(Map<String, dynamic> data)
      : opensAt = getTimeOfDay(data['opens_at']),
        closesAt = getTimeOfDay(data['closes_at']);

  String toTimeString(BuildContext context) {
    return '${opensAt?.format(context)} - ${closesAt?.format(context)}';
  }
}

TimeOfDay getTimeOfDay(int? time) {
  final int hour = int.parse(time.toString().substring(0, 2));
  final int minute = int.parse(time.toString().substring(2, 4));

  return TimeOfDay(hour: hour, minute: minute);
}
