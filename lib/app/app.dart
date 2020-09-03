import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/services/db.dart';

import 'pages/home.dart';

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBHelper>(
      create: (_) => DBHelper(db: DB()),
      child: MaterialApp(
        title: 'My Reminder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.deepPurple,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.grey[900]),
          splashColor: Colors.white12,
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
      ),
    );
  }
}
