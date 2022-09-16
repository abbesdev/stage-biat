import 'dart:convert';
import 'dart:developer';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/business_logic/models/User.dart';
import 'package:BiatRDV/src/views/screens/chefAgenceFolder/home_chef.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class SettingsClient extends StatefulWidget {
  const SettingsClient({Key? key}) : super(key: key);

  @override
  State<SettingsClient> createState() => _SettingsClientState();
}

class _SettingsClientState extends State<SettingsClient> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: height / 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profil",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        SizedBox(
          height: height / 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      width: 2, color: Color.fromARGB(255, 11, 36, 57))),
              child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 120,
                        height: 120,
                      ))),
            )
          ],
        ),
        SizedBox(
          height: height / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: _fetchAllUsers2(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  return Text(
                    "${snapshot.data}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  );
                })
          ],
        ),
        SizedBox(
          height: height / 90,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: _fetchAllUsers(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  return Text(
                    "Chef d'agence " + "${snapshot.data}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  );
                })
          ],
        ),
      ]),
    );
  }

  Future<String> _fetchAllUsers() async {
    var mytid = await storage.read(key: "userid");
    final userListEndpoint = URL + '/api/auth/user/' + mytid!;
    var myt = await storage.read(key: "jwt");

    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    var jsonResponse = json.decode(response.body);
    print(jsonResponse['idAgence']);
    final agencesList = URL + '/api/agences/' + jsonResponse['idAgence'];

    final response2 = await http.get(Uri.parse(agencesList),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    var jsonResponsea = json.decode(response2.body);

    if (response.statusCode == 200) {
      return jsonResponsea['agence'];
    } else {
      throw Exception('Failed to load Users from API');
    }
  }

  Future<String> _fetchAllUsers2() async {
    var mytid = await storage.read(key: "userid");
    final userListEndpoint = URL + '/api/auth/user/' + mytid!;
    var myt = await storage.read(key: "jwt");

    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    var jsonResponse = json.decode(response.body);
    print(jsonResponse['id']);
    if (response.statusCode == 200) {
      return jsonResponse['fullname'];
    } else {
      throw Exception('Failed to load Users from API');
    }
  }
}
