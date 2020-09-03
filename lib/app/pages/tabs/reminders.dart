import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/app/pages/new_reminder.dart';
import 'package:reminders_app/components/reminder_list_item.dart';
import 'package:reminders_app/model/reminder.dart';
import 'package:reminders_app/services/db.dart';

class RemindersPage extends StatefulWidget {
  RemindersPage({Key key}) : super(key: key);

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<DBHelper>(context).reminders ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My reminders",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewReminderPage(),
          ));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list.isEmpty) return Container();
          return ReminderListItem(
            reminder: list[index],
          );
        },
      ),
    );
  }
}
