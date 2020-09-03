import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/constant/colors.dart';
import 'package:reminders_app/model/reminder.dart';
import 'package:reminders_app/services/db.dart';

class NewReminderPage extends StatefulWidget {
  NewReminderPage({Key key}) : super(key: key);

  @override
  _NewReminderPageState createState() => _NewReminderPageState();
}

class _NewReminderPageState extends State<NewReminderPage> {
  Reminder reminder = Reminder(
    content: "",
    time: DateTime.now(),
    repeat: Repeat.daily,
  );

  bool validated = false;

  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  bool error = false;

  @override
  void didChangeDependencies() {
    final reminder = ModalRoute.of(context).settings.arguments;
    if (reminder != null && reminder is Reminder) {
      this.reminder = ModalRoute.of(context).settings.arguments;
      _controller = TextEditingController(text: this.reminder.content);
    }

    super.didChangeDependencies();
  }

  void _addReminder() async {
    final provider = Provider.of<DBHelper>(context, listen: false);
    if (reminder.content.isNotEmpty) {
      provider.insert(reminder);
      Navigator.of(context).pop();
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _controller.text.isEmpty ? "Add reminder" : "Update reminder",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: Icon(Icons.done),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _inputLabel("What are you going to do?"),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                style: TextStyle(fontSize: 20),
                autocorrect: false,
                decoration: InputDecoration(
                  errorText: error ? "*this field cannot be empty!" : null,
                ),
                onChanged: (text) {
                  reminder.content = text;
                  if (text.isNotEmpty) {
                    setState(() {
                      error = false;
                    });
                  }
                },
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
                      initialTime: TimeOfDay.fromDateTime(reminder.time),
                    );
                    setState(() {
                      if (time != null) {
                        reminder.time =
                            DateTime(0, 0, 0, time.hour, time.minute);
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
                      "${TimeOfDay.fromDateTime(reminder.time).format(context)}",
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
      ),
    );
  }

  Widget _colorSquare(int color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          reminder.color = color;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(4.0),
          color: Color(color),
        ),
        height: reminder.color == color ? 50 : 40,
        width: reminder.color == color ? 50 : 40,
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
