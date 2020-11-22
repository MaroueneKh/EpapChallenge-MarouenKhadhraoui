
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file:///C:/Users/marou/AndroidStudioProjects/reminder_app/lib/widgets/edit_widget.dart';
import 'package:reminder_app/models/db_wrapper.dart';
import 'package:reminder_app/models/reminder.dart';
import 'file:///C:/Users/marou/AndroidStudioProjects/reminder_app/lib/widgets/reminder_widget.dart';
import 'file:///C:/Users/marou/AndroidStudioProjects/reminder_app/lib/widgets/addreminder.dart';
import 'package:reminder_app/constants/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reminders',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to greenone and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reminder> reminders;
static bool _changeAppbar = true ;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Utils.getshowEdit() ? Text("Reminders") : EditWidget(delete: deleteReminder,edit:editReminder,reminder: Utils.getId(),),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[
            SingleChildScrollView(
              child: InteractiveViewer(
                scaleEnabled: true,
                panEnabled: true,
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.02),
                    child: Container(
                      height: Get.height * 0.85,
                      width: Get.width * 0.95,
                      child: Stack(children: [
                        FutureBuilder(
                          future: getReminders(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ReminderWidget(reminders: reminders);
                            } else {
                              return LinearProgressIndicator();
                            }
                          },
                        ),
                        Positioned(
                          bottom: Get.height * 0.01,
                          right: Get.height * 0.01,
                          child: FloatingActionButton(
                            onPressed: () =>
                                Get.to(AddReminder(onSubmitted: addReminer)),
                            backgroundColor: greenone,
                            child: Icon(Icons.add),
                          ),
                        )
                      ]),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Reminder>> getReminders() async {
    final _reminders = await DBWrapper.sharedInstance.getReminders();

    setState(() {
      reminders = _reminders;
    });
    return _reminders;
  }
  void editReminder({@required Reminder reminder}) {
    DBWrapper.sharedInstance.editReminder(reminder);
    getReminders();
  }
  void deleteReminder({@required Reminder reminder}) {
    DBWrapper.sharedInstance.deleteReminder(reminder);
    Utils.setshowEdit(true);
    
  }
  
  Future<void> addReminer(
      {@required TextEditingController titlecontroller,
      @required TextEditingController datecontroller,
      @required TextEditingController timecontroller,
      String repeat}) async {
    final title = titlecontroller.text.trim();
    final date = datecontroller.text.trim();
    final time = timecontroller.text.trim();
    print("dada");
    print(title);
    print(date);
    print(time);
    print(time);
    print(repeat);
    if ((title.length > 0) && (date.length > 0) && (time.length > 0)) {
      Reminder reminder = Reminder(
        title: title,
        created: DateTime.now(),
        updated: DateTime.now(),
        reminderdate: date + " " + time,
        repetition: repeat,
      );

      DBWrapper.sharedInstance.addReminder(reminder);
      if (repeat == "Repeat") {
        await Utils.addNotification(
            date, time, flutterLocalNotificationsPlugin, title,reminders).whenComplete(() => Get.snackbar(
            'Success', 'you just Added a new reminder!',
            colorText: Colors.white,
            icon: Icon(Icons.check),
            duration: Duration(seconds: 5),
            backgroundColor: greenone));
      } else if (repeat == "Everyday") {
        await Utils.addNotificationDaily(
            date, time, flutterLocalNotificationsPlugin,title, reminders).whenComplete(() => Get.snackbar(
            'Success', 'you just Added a new reminder!',
            colorText: Colors.white,
            icon: Icon(Icons.check),
            duration: Duration(seconds: 5),
            backgroundColor: greenone));
      } else if (repeat == "Every week") {
        await Utils.addNotificationWeekly(
            date, time, flutterLocalNotificationsPlugin,title,reminders).whenComplete(() => Get.snackbar(
            'Success', 'you just Added a new reminder!',
            colorText: Colors.white,
            icon: Icon(Icons.check),
            duration: Duration(seconds: 5),
            backgroundColor: greenone));
      }
    }

  }
}
