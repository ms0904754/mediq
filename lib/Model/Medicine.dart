import 'dart:ui';
import 'package:flutter/material.dart';

class Medicine {
  String name;
  String timing;
  String beforeAfter;
  int day;
  String status;
  DateTime time;
  Color color;
  String type;
  double quantity;
  int totalCount;
  String frequency;
  String timesPerDay;
  int compartment;

  Medicine({
    required this.name,
    required this.timing,
    required this.beforeAfter,
    required this.day,
    required this.status,
    required this.time,
    required this.color,
    required this.type,
    required this.quantity,
    required this.totalCount,
    required this.frequency,
    required this.timesPerDay,
    required this.compartment,
  });
}