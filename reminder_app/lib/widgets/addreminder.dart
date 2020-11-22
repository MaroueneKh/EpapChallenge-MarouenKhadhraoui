import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:reminder_app/constants/constants.dart';
class AddReminder extends StatefulWidget {
  final Function onSubmitted;
  AddReminder({@required Function this.onSubmitted});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  _AddReminderState createState() => _AddReminderState();
}




class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String chosentime;
  Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);

  final dateformat = DateFormat("yyyy-MM-dd");
  final timeformat = DateFormat("HH:mm:ss");
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
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height*0.15), // here the desired height
          child: AppBar(
            leading: BackButton(
              color: Colors.white,
            ),
            centerTitle: false,
            toolbarHeight: Get.height*0.15,
            title: Padding(
              padding:  EdgeInsets.only(top: Get.height*0.08),
              child: Text("Reminders"),
            ),
          )
      ),
      body: Container(
        height: Get.height*0.8,
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
                                        padding:  EdgeInsets.only(left: Get.width*0.08),
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
                                        padding:  EdgeInsets.only(left: Get.width*0.08),
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
                                              else  if (value.isBefore(DateTime.now())) {
                                                return 'Please verifiy the date';
                                              }
                                              return null;
                                            },
                                            controller: dateController,
                                            format: dateformat,
                                            onShowPicker: (context, currentValue) {
                                              return showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1900),
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
                                        padding:  EdgeInsets.only(left: Get.width*0.08),
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
                                              else  if (value.isBefore(DateTime.now())) {
                                                  return 'Please verifiy the time';
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
                                        padding:  EdgeInsets.only(left: Get.width*0.08),
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
                                            minWidth: Get.width*0.5,
                                            maxWidth: Get.width*0.5,
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
                      widget.onSubmitted(titlecontroller:titleController,datecontroller:dateController,timecontroller:timeController,repeat:chosentime) ;

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
      ),
    );
  }
}
