import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/CalendarClient.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/DemandeClient.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/HomeClient.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/SettingsClient.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Client extends StatefulWidget {
  const Client(String s, {Key? key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  var userUID = storage.read(key: "userid");
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const HomeClient(), "title": "Screen A Title"},
    {"screen": const CalendarClient(), "title": "Screen B Title"},
    {"screen": const DemandeClient(), "title": "Screen C Title"},
    {"screen": const SettingsClient(), "title": "Screen D Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0XFF000000),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.notifications_none,
                color: Color(0XFF000000),
              ),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: width / 5,
                        ),
                        Text(
                          "Biat",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 48, 48),
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              letterSpacing: 0.1),
                        ),
                        SizedBox(
                          width: width / 4.5,
                        )
                      ],
                    )
                  ]),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: const Text('Disconnect'),
              onTap: () async {
                await storage.delete(key: 'jwt');
                await storage.delete(key: 'userid');
                if (await storage.read(key: 'jwt') == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                }
              },
            ),
          ],
        ),
      ),
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
                Icons.file_copy,
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
