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

class SettingsChef extends StatefulWidget {
  const SettingsChef({Key? key}) : super(key: key);

  @override
  State<SettingsChef> createState() => _SettingsChefState();
}

class _SettingsChefState extends State<SettingsChef> {
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
