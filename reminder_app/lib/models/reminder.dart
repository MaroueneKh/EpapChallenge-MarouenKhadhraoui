class Reminder {
  int id;
  String title;
  DateTime created;
  DateTime updated;
  String reminderdate;

  String repetition;


  Reminder(
      {this.id, this.title, this.created, this.updated, this.reminderdate, this.repetition});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'reminderdate': reminderdate,
      'repetition': repetition,
    };
  }

  Map<String, dynamic> toMapAutoID() {
    return {
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'reminderdate': reminderdate,
      'repetition': repetition,
    };
  }

}