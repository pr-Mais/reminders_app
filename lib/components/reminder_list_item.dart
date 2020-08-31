import 'package:flutter/material.dart';
import 'package:reminders_app/app/pages/update_reminder.dart';
import 'package:reminders_app/model/reminder.dart';

class ReminderListItem extends StatelessWidget {
  ReminderListItem({
    Key key,
    this.reminder,
  }) : super(key: key);
  final Reminder reminder;

  Future<bool> _showConfirmDialog(
      String title, String content, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$title"),
          content: Container(
            child: Text("$content"),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes, sure!"),
              textColor: Colors.grey,
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Nope"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }

  Future<bool> _confirmDismiss(
      DismissDirection direction, BuildContext context) {
    final content = direction == DismissDirection.endToStart
        ? "Are you sure you want to delete this reminder forever?"
        : "Are you sure you want to move this reminder to archive?";
    final title = direction == DismissDirection.endToStart
        ? "Delete Reminder"
        : "Archive Reminder";
    return _showConfirmDialog(title, content, context);
  }

  @override
  Widget build(BuildContext context) {
    double radius = 5.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ObjectKey(reminder),
        onDismissed: (direction) {
          //TODO implement move reminder to archive
          //TODO also implement delete reminder if moved to other direction
          //moving a reminder to archive will disable its notifications
        },
        confirmDismiss: (direction) => _confirmDismiss(direction, context),
        dismissThresholds: {DismissDirection.endToStart: 0.2},
        background: Container(
          padding: EdgeInsets.only(left: 28.0),
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          height: 60,
          child: Icon(
            Icons.archive,
            color: Theme.of(context).primaryColor,
          ),
        ),
        secondaryBackground: Container(
          padding: EdgeInsets.only(right: 28.0),
          alignment: AlignmentDirectional.centerEnd,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.redAccent.withOpacity(0.2),
          ),
          height: 60,
          child: Icon(
            Icons.delete_forever,
            color: Colors.redAccent,
          ),
        ),
        direction: DismissDirection.horizontal,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black12,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: reminder.color,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                          topLeft: Radius.circular(radius)),
                    ),
                    width: 10.0,
                  ),
                  SizedBox(width: 15),
                  Text(
                    reminder.content,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(550),
                  clipBehavior: Clip.hardEdge,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UpdateReminderPage(),
                            fullscreenDialog: true,
                            settings: RouteSettings(arguments: reminder)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
