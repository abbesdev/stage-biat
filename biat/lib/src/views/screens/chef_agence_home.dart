import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/views/screens/chefAgenceFolder/calendar_chef.dart';
import 'package:BiatRDV/src/views/screens/chefAgenceFolder/history_chef.dart';
import 'package:BiatRDV/src/views/screens/chefAgenceFolder/home_chef.dart';
import 'package:BiatRDV/src/views/screens/chefAgenceFolder/settings_chef.dart';
import 'package:flutter/material.dart';

class ChefAgenceHome extends StatefulWidget {
  @override
  _ChefAgenceHomeState createState() => _ChefAgenceHomeState();
}

class _ChefAgenceHomeState extends State<ChefAgenceHome> {
  var userUID = storage.read(key: "userid");
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const HomeChef(), "title": "Screen A Title"},
    {"screen": const CalendarChef(), "title": "Screen B Title"},
    {"screen": const HistoryChef(), "title": "Screen C Title"},
    {"screen": const SettingsChef(), "title": "Screen D Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0Xff004579),
            ),
            label: 'Screen A',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_sharp,
                color: Color(0Xff004579),
              ),
              label: "Screen B"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_view_day_sharp,
                color: Color(0Xff004579),
              ),
              label: 'Screen C'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color(0Xff004579),
              ),
              label: "Screen D")
        ],
      ),
    );
  }
}
