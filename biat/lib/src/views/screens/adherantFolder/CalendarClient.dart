import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/business_logic/models/Rdv.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/AjouterRDV.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

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
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                children: [
                  SizedBox(
                      width: width - 32,
                      height: height / 1.5,
                      child: FutureBuilder<List<Rdv>>(
                          future: _fetchAllRdvs(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Rdv>? data = snapshot.data;
                              return _rdvListView(data);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return Container(
                              child: Text("no data"),
                            );
                          }))
                ],
              )),
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

  ListView _rdvListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _rdvContainer(
              data[index].title,
              data[index].startDate.toString(),
              data[index].endDate.toString(),
              data[index].status);
        });
  }
}
