import 'package:flutter/material.dart';
import 'update_reminder.dart';
import 'tabs/reminders.dart';
import 'tabs/archive.dart';
import 'tabs/more.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController _pageController;
  int index = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void _openAddReminderPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateReminderPage(),
        fullscreenDialog: true,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          RemindersPage(),
          ArchivePage(),
          MorePage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        currentIndex: index,
        onTap: _onBottomNavTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Container(),
          )
        ],
      ),
    );
  }
}
