import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import '../../../business_logic/apis/userApi.dart';

class AjouterRDV extends StatefulWidget {
  const AjouterRDV({Key? key}) : super(key: key);

  @override
  State<AjouterRDV> createState() => _AjouterRDVState();
}

TextEditingController typed = TextEditingController();

class _AjouterRDVState extends State<AjouterRDV> {
  String dropdownValue = 'user';
  String valueApi = '';
  late DateTime startD;
  late DateTime endD;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0XFF000000),
            ),
            onPressed: () {
              Navigator.pop(context);
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
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              children: [
                Container(
                    width: width - 32,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: typed,
                      decoration: InputDecoration(
                        fillColor: const Color(0xfffaebeb),
                        contentPadding: const EdgeInsets.all(25),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xFF004579)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xffE64646)),
                        ),
                        disabledBorder: InputBorder.none,
                      ),
                      autofocus: true,
                      obscureText: false,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              children: [
                SizedBox(
                    width: width - 40,
                    height: 80,
                    child: FutureBuilder<List<User>>(
                        future: _fetchAllU(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<User>? data = snapshot.data;
                            return DropdownButton(
                                hint: Text("Select agency"),
                                isExpanded: true,
                                items: data!.map((agence) {
                                  return DropdownMenuItem(
                                    child: Text(agence.id),
                                    value: agence.id,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  valueApi = value.toString();
                                  print("Selected agency is $value");
                                });
                          } else {
                            return Text("no agencies");
                          }
                        }))
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2030, 6, 7, 05, 09), onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  startD = date;
                  print('confirm $date');
                }, locale: LocaleType.en);
              },
              child: Text(
                'show date time picker start time',
                style: TextStyle(color: Colors.blue),
              )),
          TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2030, 6, 7, 05, 09), onChanged: (date1) {
                  print('change $date1 in time zone ' +
                      date1.timeZoneOffset.inHours.toString());
                }, onConfirm: (date1) {
                  endD = date1;
                  print('confirm $date1');
                }, locale: LocaleType.en);
              },
              child: Text(
                'show date time picker end time',
                style: TextStyle(color: Colors.blue),
              )),
          GestureDetector(
            onTap: (() => dPost(typed.text)),
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFF004579),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: const Text(
                "Ajouter Demande",
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.1),
              )),
            ),
          )
        ],
      )),
    );
  }

  Future<int> dPost(String typed) async {
    var myt = await storage.read(key: "jwt");
    var mytid = await storage.read(key: "userid");
    final testing = await http.post(
      Uri.parse(URL + '/api/rdvs'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer ' + myt.toString()
      },
      body: jsonEncode({
        "title": typed,
        "description": "Not Yet",
        "clientId": mytid,
        "chefId": valueApi,
        "status": "upcoming",
        "startDate": startD.toString(),
        "endDate": endD.toString()
      }),
    );
    print(testing.body);
    return testing.statusCode;
  }

  Future<List<User>> _fetchAllU() async {
    var mytag = await storage.read(key: "userAgence");
    print(mytag);
    final userListEndpoint = URL + '/api/auth/userr/' + mytag.toString();
    var myt = await storage.read(key: "jwt");
    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    String totalChefs = response.body.length.toString();
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => new User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load Users from API');
    }
  }
}
