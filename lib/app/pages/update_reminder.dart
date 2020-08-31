import 'package:flutter/material.dart';
import 'package:reminders_app/constant/colors.dart';
import 'package:reminders_app/model/reminder.dart';

class UpdateReminderPage extends StatefulWidget {
  UpdateReminderPage({Key key}) : super(key: key);

  @override
  _UpdateReminderPageState createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  Reminder reminder = Reminder(
    time: TimeOfDay.now(),
    repeat: Repeat.daily,
  );

  TextEditingController _controller;

  @override
  void didChangeDependencies() {
    final reminder = ModalRoute.of(context).settings.arguments;
    if (reminder != null && reminder is Reminder) {
      this.reminder = ModalRoute.of(context).settings.arguments;
    }
    _controller = TextEditingController(text: this.reminder.content);
    super.didChangeDependencies();
  }

  void _addReminder() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addReminder,
        label: Text("Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add reminder",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20),
            _inputLabel("What are you going to do?"),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              style: TextStyle(fontSize: 20),
              autocorrect: false,
            ),
            SizedBox(height: 20),
            _inputLabel("How often?"),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              value: reminder.repeat,
              items: [
                DropdownMenuItem(
                  child: Text(
                    "Daily",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: Repeat.daily,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Weekly",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: Repeat.weekly,
                ),
                DropdownMenuItem(
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: Repeat.monthly,
                ),
              ],
              dropdownColor: Colors.grey[100],
              onChanged: (value) {
                setState(() {
                  reminder.repeat = value;
                });
              },
              isExpanded: true,
              elevation: 0,
              isDense: true,
            ),
            SizedBox(height: 20),
            _inputLabel("When?"),
            SizedBox(height: 10),
            Material(
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: reminder.time,
                  );
                  setState(() {
                    if (time != null) {
                      reminder.time = time;
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${reminder.time.format(context)}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Choose a color",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int color in REMINDER_COLOR) _colorSquare(color)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorSquare(int colorCode) {
    return GestureDetector(
      onTap: () {
        print(colorCode);
        setState(() {
          reminder.color = colorCode;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(4.0),
          color: Color(colorCode),
        ),
        height: reminder.color == colorCode ? 50 : 40,
        width: reminder.color == colorCode ? 50 : 40,
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
