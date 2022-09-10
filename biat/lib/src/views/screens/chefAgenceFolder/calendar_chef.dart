import 'dart:convert';

import 'dart:math';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/business_logic/models/Rdv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../sign_in.dart';
import 'home_chef.dart';

class CalendarChef extends StatefulWidget {
  const CalendarChef({Key? key}) : super(key: key);

  @override
  State<CalendarChef> createState() => _CalendarChefState();
}

DateTime _convertDateFromString(String date) {
  return DateTime.parse(date);
}

class _CalendarChefState extends State<CalendarChef> {
  String? _networkStatusMsg;
  late DateTime selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late List<CleanCalendarEvent> selectedEvent;

  Future<List<Rdv>> _fetchAllRdvs() async {
    var mytuid = await storage.read(key: "userid");
    final userListEndpoint = URL + '/api/rdvss/' + mytuid.toString();
    var myt = await storage.read(key: "jwt");

    final data = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      final List<Rdv> appointmentData = [];
      final Random random = new Random();
      for (var data in jsonData) {
        Rdv meetingData = Rdv(
          title: data['title'],
          description: data['description'],
          startDate: _convertDateFromString(data['startDate']),
          endDate: _convertDateFromString(data['endDate']),
          clientId: data['clientId'],
          chefId: data['chefId'],
          status: data['status'],
        );

        appointmentData.add(meetingData);
      }

      return appointmentData;
    } else {
      throw Exception('Failed to load Users from API');
    }
  }

/*
  final Map<DateTime, List<CleanCalendarEvent>> events = _fetchAllRdvs() as Map<DateTime, List<CleanCalendarEvent>>;
  
  {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
    ],
  };
  */

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              leading: Icon(Icons.home),
              title: const Text('Acceuil'),
              onTap: () {
                // Then close the drawer
                Navigator.pop(context, HomeChef());
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Calendrier'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeChef()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Modifier les horaires de travail'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text("Historique des rendez-vous"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeChef()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text("Parametres de l'application"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeChef()));
              },
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
      body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Calendrier",
                                style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height / 70,
                          ),
                          Row(
                            children: [
                              Text(
                                "voir tous les Rendez vous.",
                                style: TextStyle(
                                    color: Color(0xFF7D7D7D),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    letterSpacing: 0.1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.list_outlined)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.calendar_month_rounded))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Container(
                  width: width - 32,
                  height: height / 1.2,
                  child: FutureBuilder(
                    future: _fetchAllRdvs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return SafeArea(
                          child: Column(
                            children: [
                              Container(
                                  height: height / 1.2,
                                  child: SfCalendar(
                                    onTap: (CalendarTapDetails details) {
                                      String? _subjectText = '',
                                          _startTimeText = '',
                                          _endTimeText = '',
                                          _clientText = '',
                                          _dateText = '',
                                          _timeDetails = '';
                                      Color? _headerColor,
                                          _viewHeaderColor,
                                          _calendarColor;
                                      if (details.targetElement ==
                                              CalendarElement.appointment ||
                                          details.targetElement ==
                                              CalendarElement.agenda) {
                                        final Rdv appointmentDetails =
                                            details.appointments![0];
                                        _subjectText = appointmentDetails.title;
                                        _clientText =
                                            appointmentDetails.clientId;
                                        _dateText = appointmentDetails.startDate
                                            .toString();
                                        _startTimeText =
                                            (appointmentDetails.startDate)
                                                .toString();
                                        _endTimeText =
                                            (appointmentDetails.endDate)
                                                .toString();
                                        showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                  height: height / 2,
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Objet du Rendez-vous :",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          23,
                                                                          56,
                                                                          84),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ]),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '$_subjectText',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Client ID :",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          23,
                                                                          56,
                                                                          84),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ]),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '$_clientText',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Date and Time of Start :",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          23,
                                                                          56,
                                                                          84),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ]),
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '$_dateText',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Date and Time of End :",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          23,
                                                                          56,
                                                                          84),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ]),
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                  _endTimeText
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16)),
                                                            ],
                                                          ),
                                                          ElevatedButton(
                                                            child: const Text(
                                                              'Close Details',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                          )
                                                        ]),
                                                  )));
                                            });
                                      }
                                    },
                                    monthViewSettings:
                                        MonthViewSettings(showAgenda: true),
                                    view: CalendarView.month,
                                    initialDisplayDate: DateTime.now(),
                                    dataSource:
                                        MeetingDataSource(snapshot.data),
                                  )),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text('$_networkStatusMsg'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ]))),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Rdv> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDate;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }
}

class Meeting {
  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.allDay = false});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? allDay;
}
