import 'package:reminder_app/models/db.dart';
import 'package:reminder_app/models/reminder.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<Reminder>> getReminders() async {
    List list = await DB.sharedInstance.retrieveReminders();
    return list;
  }

  void addReminder(Reminder reminder) async {
    await DB.sharedInstance.createReminder(reminder);
  }

  void deleteReminder(Reminder reminder) async {
    await DB.sharedInstance.deleteReminder(reminder);
  }
  void editReminder(Reminder reminder) async {
    await DB.sharedInstance.updateTodo(reminder);
  }
  void deleteAllReminders() async {
    await DB.sharedInstance.deleteAllReminders();
  }
}