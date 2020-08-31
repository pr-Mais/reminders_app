import 'package:flutter/material.dart';
import 'package:reminders_app/constant/colors.dart';

import 'pages/home.dart';

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Reminder',
      theme: ThemeData(
        primaryColor: Color(PRIMARY_COLOR),
        canvasColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(PRIMARY_COLOR),
        ),
        splashColor: Colors.grey[200],
        highlightColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200],
            ),
          ),
        ),
      ),
      home: Home(),
    );
  }
}
