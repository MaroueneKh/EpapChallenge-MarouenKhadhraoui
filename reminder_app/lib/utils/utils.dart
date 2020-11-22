import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/models/reminder.dart';

class Utils {

  static  bool _showEdit = true ;

  static  Reminder _reminderTodelete;

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static bool getshowEdit()
  {
    return _showEdit ;
  }
  static void setshowEdit(bool value)
  {
    _showEdit = value ;
  }
  static void setshowEditReminder(Reminder reminder)
  {
    _reminderTodelete = reminder ;
  }
  static Reminder getId()
  {
    return _reminderTodelete ;
  }
  //convert date to String and get the appropriate date to display
  static String returnDate(String reminderDateString) {
    DateTime reminderdate =
        new DateFormat("yyyy-MM-dd").parse(reminderDateString.substring(0, 10));
    DateTime justdate =
        DateTime(reminderdate.year, reminderdate.month, reminderdate.day);
    DateTime now = new DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (justdate == today)
      return "Today";
    else if (justdate == tomorrow)
      return "Tomorrow";
    else
      return reminderDateString.substring(0, 10);
  }
//returns time from the date and time string
  static String returnTime(String reminderTimeString) {
    return reminderTimeString.substring(11, 16);
  }
//adds a notification with specfic date and time
  static Future<void> addNotification(
      String date,
      String time,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String title ,
      List<Reminder> reminders) async {
    DateTime reminderdate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date + " " + time);
    var scheduledNotificationDateTime = reminderdate;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id',
      'channel',
      'description',
      icon: '@mipmap/ic_launcher',
      playSound: true
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .schedule(
          reminders.length + 1,
          title,
          title,
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
        )
       ;
  }
//adds a daily  with specfic time
  static Future<void> addNotificationDaily(
      String date,
      String time,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,String title ,
      List<Reminder> reminders) async {
    DateTime reminderdate = new DateFormat("hh:mm:ss").parse(time);
    var timereminder = new Time(reminderdate.hour, reminderdate.minute, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id',
      'channel',
      'description',
      icon: '@mipmap/ic_launcher',
      playSound: true
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .showDailyAtTime(
          reminders.length + 1,
          title,
         title,
          timereminder,
          platformChannelSpecifics,
          payload: 'Default_Sound',
        )
       ;
  }
//adds a weekly with specfic time
  static Future<void> addNotificationWeekly(
      String date,
      String time,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,String title ,
      List<Reminder> reminders) async {
    DateTime reminderdate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
    var timereminder = new Time(reminderdate.hour, reminderdate.minute, 0);


    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id',
      'channel',
      'description',
      icon: '@mipmap/ic_launcher',
      playSound: true
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .showWeeklyAtDayAndTime(
      reminders.length + 1,
          title,
          title, //null
          Day.values.elementAt(reminderdate.weekday),
          timereminder,
          platformChannelSpecifics,
          payload: 'Test Payload',
        )
        ;
  }
}
