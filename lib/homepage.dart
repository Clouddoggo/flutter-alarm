import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      color: Colors.red[50],
    );
  }

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
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              title: Text(
                'Alarms',
                style: _buildTextStyle(),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20.0,
              ),
              title: Text(
                'Settings',
                style: _buildTextStyle(),
              ),
            ),
          ],
          currentIndex: _selectedPage,
          unselectedIconTheme: IconThemeData(color: Colors.yellow[50]),
          selectedIconTheme:
              IconThemeData(color: Color(0xffFCD344), size: 35.0),
          onTap: (page) => _onTabTapped(page),
        ),
      ),
    );
  }
}
