import 'package:flutter/material.dart';
import 'package:reminders_app/components/reminder_list_item.dart';
import 'package:reminders_app/constant/colors.dart';
import 'package:reminders_app/model/reminder.dart';

class RemindersPage extends StatefulWidget {
  RemindersPage({Key key}) : super(key: key);

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My reminders",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        itemCount: modalData.length,
        itemBuilder: (context, index) {
          return ReminderListItem(
            reminder: modalData[index],
          );
        },
      ),
    );
  }
}

// TODO remove this data after making DB service
List modalData = [
  Reminder(
    content: "Drink a glass of water",
    color: REMINDER_COLOR[0],
    time: TimeOfDay.now(),
    repeat: Repeat.daily,
  ),
  Reminder(
    content: "Time to read",
    color: REMINDER_COLOR[1],
    time: TimeOfDay.now(),
    repeat: Repeat.daily,
  ),
  Reminder(
    content: "Check email",
    color: REMINDER_COLOR[2],
    time: TimeOfDay.now(),
    repeat: Repeat.daily,
  )
];
