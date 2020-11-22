
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:reminder_app/constants/constants.dart';

class ReminderColor {
  static const kPrimaryColorCode = 0xffca3e47;
  static const kSecondaryColorCode = 0xff34465d;

  static ReminderColor sharedInstance = ReminderColor._();

  List<Color> storedColors;

  ReminderColor._() {
    storedColors = List.generate(100, (pos) {
      return ColorsBase.elementAt(new Random().nextInt(5)) ;
    });
  }

}