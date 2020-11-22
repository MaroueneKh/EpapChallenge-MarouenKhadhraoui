import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/utils/colors.dart';
import 'package:reminder_app/utils/utils.dart';

class ReminderWidget extends StatefulWidget {
  ReminderWidget({Key key, @required this.reminders}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final List<Reminder> reminders;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(53, 46, 155, 1.0);

  @override
  Future<void> initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ((widget.reminders == null) || (widget.reminders.length == 0))
        ? Container(
            child: Center(
                child: Text(
              "No reminders yet",
              style: TextStyle(fontSize: 20),
            )),
          )
        : ListView.builder(
            itemCount: widget.reminders.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: (){
                  Utils.setshowEdit(false);
                  Utils.setshowEditReminder(widget.reminders[index]);
                }   ,
                child: GestureDetector(
                  excludeFromSemantics: true,
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7)),
                        boxShadow: [
                          BoxShadow(
                            color: secondColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: Get.height * 0.09,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: Get.height * 0.07,
                              width: Get.width * 0.01,
                              color: ReminderColor.sharedInstance.storedColors
                                  .elementAt(index),
                            ),
                          ),
                          Text(
                            widget.reminders[index].title,
                            style: TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.55),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Get.height * 0.015),
                                  //   child: Text(Utils.returnDate(widget.reminders[index].reminderdate),style:TextStyle(
                                  //     color: Colors.black
                                  //),),
                                  child: Text(
                                    Utils.returnDate(
                                        widget.reminders[index].reminderdate),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: Get.height * 0.02),
                                  //   child: Text(Utils.returnTime(widget.reminders[index].reminderdate),style:TextStyle(
                                  //     color: Colors.black
                                  //),),
                                  child: Text(
                                    Utils.returnTime(
                                        widget.reminders[index].reminderdate),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
}
