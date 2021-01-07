import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'alarmsList.dart';
import "settings.dart";

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    AlarmsListPage(),
    SettingsPage(),
  ];

  void pageChanged(index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final controller = PageController(
    initialPage: 0,
  );

  void _onTabTapped(int page) {
    setState(() {
      _selectedPage = page;
      controller.jumpToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      body: PageView(
        controller: controller,
        children: _widgetOptions,
        onPageChanged: (idx) => pageChanged(idx),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: BottomNavigationBar(
          backgroundColor: Color(0xff0785CC),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.alarm,
                size: 20.0,
              ),
              label: 'Alarms',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20.0,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Color(0xffFCD344),
          unselectedItemColor: Colors.yellow[50],
          onTap: (page) => _onTabTapped(page),
        ),
      ),
    );
  }
}
