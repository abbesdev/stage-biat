import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/business_logic/models/Rdv.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/AjouterRDV.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../chefAgenceFolder/calendar_chef.dart';

class CalendarClient extends StatefulWidget {
  const CalendarClient({Key? key}) : super(key: key);

  @override
  State<CalendarClient> createState() => _CalendarClientState();
}

class _CalendarClientState extends State<CalendarClient> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AjouterRDV()));
                      },
                      child: Expanded(
                        child: Container(
                          width: width / 1.2,
                          height: 60,
                          color: Colors.blue,
                          child: Center(
                              child: Text(
                            'Ajouter un RDV',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ))
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Tous les rendez-vous",
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.1),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: FutureBuilder(
                future: _fetchAllRdvs(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Container(
                              height: height / 1.3,
                              child: SfCalendar(
                                onTap: (CalendarTapDetails details) {
                                  String? _rdvId = '',
                                      _subjectText = '',
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
                                    _rdvId = appointmentDetails.id;
                                    _subjectText = appointmentDetails.title;
                                    _clientText = appointmentDetails.chefId;
                                    _dateText =
                                        appointmentDetails.startDate.toString();
                                    _startTimeText =
                                        (appointmentDetails.startDate)
                                            .toString();
                                    _endTimeText =
                                        (appointmentDetails.endDate).toString();
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height: height / 2,
                                              color: Colors.white,
                                              child: Center(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Row(children: <Widget>[
                                                        Text(
                                                          "Objet du Rendez-vous :",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      56,
                                                                      84),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
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
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(children: <Widget>[
                                                        Text(
                                                          "Chef ID :",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      56,
                                                                      84),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
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
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(children: <Widget>[
                                                        Text(
                                                          "Date and Time of Start :",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      56,
                                                                      84),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
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
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(children: <Widget>[
                                                        Text(
                                                          "Date and Time of End :",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      23,
                                                                      56,
                                                                      84),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
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
                                                            'Annuler le rendez-vous',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          onPressed: () {
                                                            _deleteRdv(_rdvId
                                                                .toString());
                                                            userUpdate();
                                                          }),
                                                      ElevatedButton(
                                                        child: const Text(
                                                          'Fermer les details',
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
                                dataSource: MeetingDataSource(snapshot.data),
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text('no internet'),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      )),
    );
  }

  Widget _rdvContainer(
      String title, String startDate, String endDate, String status) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height / 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF004579).withOpacity(0.02)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        )),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Text(status,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16,
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width / 24,
            ),
            Icon(
              Icons.calendar_month,
              color: Color(0xFFF08002),
            ),
            SizedBox(
              width: 3,
            ),
            Text(startDate,
                style: TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ))
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width / 24,
            ),
            Icon(
              Icons.timelapse,
              color: Color(0xFFF08002),
            ),
            SizedBox(
              width: 3,
            ),
            Text(endDate,
                style: TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ))
          ],
        )
      ]),
    );
  }

  Future<List<Rdv>> _fetchAllRdvs() async {
    var mytid = await storage.read(key: "userid");

    final userListEndpoint = URL + '/api/rdv/' + mytid!;
    var myt = await storage.read(key: "jwt");

    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((rdv) => new Rdv.fromJson(rdv)).toList();
    } else {
      throw Exception('Failed to load Users from API');
    }
  }

  _deleteRdv(String rdvid) async {
    final userListEndpoint = URL + '/api/rdvs/' + rdvid;
    var myt = await storage.read(key: "jwt");

    final response = await http.delete(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
  }

  Future<int> userUpdate() async {
    var mytid = await storage.read(key: "userid");
    var myt = await storage.read(key: "jwt");
    final testing = await http.put(
      Uri.parse(URL + '/api/auth/user/' + mytid!),
      headers: {
        'Authorization': 'Bearer ' + myt.toString(),
        'Content-Type': 'application/json',
        'Connection': 'keep-alive'
      },
      body: jsonEncode({"score": "0"}),
    );
    print(testing.body);
    return testing.statusCode;
  }
/*
  ListView _rdvListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return TextButton(onPressed: (){
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
                                      
          },
            child: _rdvContainer(
                data[index].title,
                data[index].startDate.toString(),
                data[index].endDate.toString(),
                data[index].status),
          );
        });
  }*/
}
