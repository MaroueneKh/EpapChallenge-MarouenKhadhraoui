import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/utils/utils.dart';
class DialogWidget extends StatefulWidget {
  final Function edit;
  final Reminder reminder;

  DialogWidget({@required Function this.edit,@required Reminder this.reminder});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}




class _DialogWidgetState extends State<DialogWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String chosentime;

  final dateformat = DateFormat("yyyy-MM-dd");
  final timeformat = DateFormat("HH:mm:ss");
  @override
  void initState() {
    chosentime = widget.reminder.repetition;

    titleController.value = TextEditingValue(
      text: widget.reminder.title,
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.reminder.title.length),
      ),
    );
    dateController.value = TextEditingValue(
      text: Utils.returnDate(widget.reminder.reminderdate),
      selection: TextSelection.fromPosition(
        TextPosition(offset: Utils.returnDate(widget.reminder.reminderdate).length),
      ),
    );
    timeController.value = TextEditingValue(
      text: Utils.returnTime(widget.reminder.reminderdate),
      selection: TextSelection.fromPosition(
        TextPosition(offset: Utils.returnTime(widget.reminder.reminderdate).length),
      ),
    );



    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: Get.height*0.6,
      width: Get.width ,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: Get.height*0.1),
          child: Stack(
            children:[
              Center(
                child: Form(
                    key: _formKey,
                    child: Container(
                      height: Get.height*0.6,
                      width: Get.width*(0.90),
                      child:Flex(
                        direction: Axis.vertical,
                        children: [
                          Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.05),
                                      child: Icon(Icons.title,color: greenone,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:Get.width*0.02),
                                      child: Text("Titre",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding:EdgeInsets.only(left: Get.width*0.05),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: Get.width*0.5,
                                              maxWidth: Get.width*0.5,
                                              maxHeight:Get.width*0.05 ,
                                              minHeight:Get.width*0.05
                                          ),
                                          child :
                                          TextFormField(
                                            controller: titleController,
                                            cursorColor:  greenone,
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please precise a title';
                                              }
                                              else  if (value.length>6) {
                                                return 'Shirter title please';
                                              }
                                              return null;
                                            },
                                          )
                                      ),
                                    ),
                                  ],
                                )
                                ,
                                Divider(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height/35,
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.05),
                                      child: Icon(Icons.calendar_today,color: greenone,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:Get.width*0.02),
                                      child: Text("Date",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding:EdgeInsets.only(left: Get.width*0.05),
                                      child:                            ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: Get.width*0.5,
                                          maxWidth: Get.width*0.5,
                                        ),
                                        child:DateTimeField(
                                          validator: (value) {
                                            if (value.isNull) {
                                              return 'Please precise a date';
                                            }
                                            return null;
                                          },
                                          controller: dateController,
                                          format: dateformat,
                                          onShowPicker: (context, currentValue) {
                                            return showDatePicker(
                                                context: context,
                                                firstDate: DateTime(DateTime.now().year),
                                                initialDate: currentValue ?? DateTime.now(),
                                                lastDate: DateTime(2100));
                                          },
                                        ),
                                      ) ,
                                    ),
                                  ],
                                )
                                ,
                                Divider(
                                  color: Colors.white,
                                  height: Get.height/35,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.05),
                                      child: Icon(Icons.access_time,color: greenone,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:Get.width*0.02),
                                      child: Text("Time",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding:EdgeInsets.only(left: Get.width*0.05),
                                      child:                            ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: Get.width*0.5,
                                          maxWidth: Get.width*0.5,
                                        ),
                                        child:  DateTimeField(
                                          controller: timeController,
                                          format: timeformat,
                                          validator: (value) {
                                            if (value.isNull) {
                                              return 'Please precise a time';
                                            }
                                            return null;
                                          },
                                          onShowPicker: (context, currentValue) async {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                            );
                                            return DateTimeField.convert(time);
                                          },
                                        ),
                                      ) ,
                                    ),
                                  ],
                                )
                                ,
                                Divider(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height/25,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.05),
                                      child: Icon(Icons.access_time,color: greenone,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:Get.width*0.02),
                                      child: Text("Repeat",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    ),
                                    Padding(
                                      padding:EdgeInsets.only(left: Get.width*0.05),
                                      child:                               ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: Get.width*0.4,
                                          maxWidth: Get.width*0.4,
                                        ),
                                        child:DropdownButton<String>(
                                          iconEnabledColor: greenone,
                                          dropdownColor: greenone,
                                          isExpanded: true,
                                          isDense: true,
                                          hint:  Text("Repeat",style: TextStyle(color: greenone)),
                                          value: chosentime,
                                          onChanged: (String Value) {
                                            setState(() {
                                              chosentime = Value;
                                            });
                                          },
                                          items: Repeat.map((String repeat) {
                                            return  DropdownMenuItem<String>(
                                              value: repeat,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    repeat,
                                                    style:  TextStyle(color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                )
                                ,
                                // Add TextFormFields and RaisedButton here.
                              ]
                          )
                        ],
                      ) ,

                    )
                ),
              ),
              Positioned(
                bottom: Get.height*0.2,
                right:Get.height*0.05 ,
                child: FloatingActionButton(
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      Reminder reminder = new Reminder(id: widget.reminder.id,repetition: chosentime,reminderdate: dateController.text.trim() + " " + dateController.text.trim(),title: titleController.text.trim(),created: widget.reminder.created,updated: DateTime.now()) ;
                      widget.edit(reminder:reminder) ;
                      Navigator.of(context).pop();
                      Get.snackbar(
                          'Success', 'you just edited a reminder!',
                          colorText: Colors.white,
                          icon: Icon(Icons.check),
                          duration: Duration(seconds: 5),
                          backgroundColor: greenone);

                    }
                  },
                  backgroundColor: greenone,
                  child: Icon(Icons.check),
                ),
              )

            ] ,
          ),
        ),
      ),
    );
  }
}
