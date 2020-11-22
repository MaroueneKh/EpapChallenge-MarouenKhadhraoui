import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:reminder_app/widgets/dialog_widget.dart';
import 'package:reminder_app/models/reminder.dart';
class EditWidget extends StatefulWidget {
  final Function edit;
  final Function delete;
  final Reminder reminder;
  EditWidget({@required Function this.edit,@required Function this.delete,@required this.reminder});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _EditWidgetState createState() => _EditWidgetState();
}




class _EditWidgetState extends State<EditWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        IconButton(
          onPressed: ()=>widget.delete(reminder:widget.reminder),
          icon: Icon(Icons.delete,color: Colors.white,
          ),
        ),
          IconButton(
           // onPressed: ()=>widget.edit(reminder:widget.reminder),
            onPressed: ()=>showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                    child:SingleChildScrollView(child: DialogWidget(edit:widget.edit ,reminder:widget.reminder ,)),
                  );
                }),
            icon: Icon(Icons.edit,color: Colors.white,
            ),
          )

        ],
      ),
      height: Get.height*0.1,
      width: Get.width*0.8,
    );
  }
}
