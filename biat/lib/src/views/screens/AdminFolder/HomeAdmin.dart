import 'dart:convert';

import 'package:BiatRDV/src/views/screens/AdminFolder/AgencesList.dart';
import 'package:BiatRDV/src/views/screens/AdminFolder/ChefList.dart';
import 'package:BiatRDV/src/views/screens/AdminFolder/ClientsList.dart';
import 'package:BiatRDV/src/views/screens/chef_agence.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../business_logic/apis/userApi.dart';
import '../../../business_logic/models/User.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
                Navigator.pop(context, HomeAdmin());
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Liste des clients'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ClientsList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Liste des demandes'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text("Liste des chefs d'agences"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChefList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Liste des agences'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgencesList()));
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
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Welcome Back Admin !",
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.1),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "voici les statistiques de votre application.",
                    style: TextStyle(
                        color: Color(0xFF7D7D7D),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 0.1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 40,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(children: [
                Expanded(
                    child: Container(
                  width: width,
                  height: height / 6,
                  decoration: BoxDecoration(
                      color: Color(0xFF004579).withOpacity(0.02),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color(0xFF000000).withOpacity(0.1), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total des clients",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: getLengthClient(),
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasError)
                                    return Text('${snapshot.error}');
                                  if (snapshot.hasData)
                                    return Text(
                                      '${snapshot.data}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 48, 48),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 36,
                                          letterSpacing: 0.1),
                                    );
                                  return const CircularProgressIndicator();
                                },
                              )
                            ],
                          ),
                        ]),
                  ),
                ))
              ])),
          SizedBox(
            height: height / 100,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(children: [
                Expanded(
                    child: Container(
                  width: width,
                  height: height / 6,
                  decoration: BoxDecoration(
                      color: Color(0xFF004579).withOpacity(0.02),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color(0xFF000000).withOpacity(0.1), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total des chefs d'agences",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: getLength(),
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasError)
                                    return Text('${snapshot.error}');
                                  if (snapshot.hasData)
                                    return Text(
                                      '${snapshot.data}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 48, 48),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 36,
                                          letterSpacing: 0.1),
                                    );
                                  return const CircularProgressIndicator();
                                },
                              )
                            ],
                          ),
                        ]),
                  ),
                ))
              ])),
          SizedBox(
            height: height / 100,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(children: [
                Expanded(
                    child: Container(
                  width: width,
                  height: height / 6,
                  decoration: BoxDecoration(
                      color: Color(0xFF004579).withOpacity(0.02),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color(0xFF000000).withOpacity(0.1), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total des demandes non lus",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: getLengthDemandes(),
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasError)
                                    return Text('${snapshot.error}');
                                  if (snapshot.hasData)
                                    return Text(
                                      '${snapshot.data}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 48, 48),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 36,
                                          letterSpacing: 0.1),
                                    );
                                  return const CircularProgressIndicator();
                                },
                              )
                            ],
                          ),
                        ]),
                  ),
                ))
              ])),
          SizedBox(
            height: height / 100,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(children: [
                Expanded(
                    child: Container(
                  width: width,
                  height: height / 6,
                  decoration: BoxDecoration(
                      color: Color(0xFF004579).withOpacity(0.02),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color(0xFF000000).withOpacity(0.1), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total des utilisateurs non verifies",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    letterSpacing: 0.1),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: getLengthUsersNotVerified(),
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasError)
                                    return Text('${snapshot.error}');
                                  if (snapshot.hasData)
                                    return Text(
                                      '${snapshot.data}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 48, 48, 48),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 36,
                                          letterSpacing: 0.1),
                                    );
                                  return const CircularProgressIndicator();
                                },
                              )
                            ],
                          ),
                        ]),
                  ),
                ))
              ])),
        ]),
      )),
    );
  }
}

Future<int> getLength() async {
  final userListEndpoint = URL + '/api/auth/users/chef';
  var myt = await storage.read(key: "jwt");
  final response = await http.get(Uri.parse(userListEndpoint),
      headers: {'Authorization': 'Bearer ' + myt.toString()});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var stores = json.decode(response.body);
    int len = stores.length;
    print('length = $len');
    return len;
  } else {
    throw Exception('Failed to load Users from API');
  }
}

Future<int> getLengthClient() async {
  final userListEndpoint = URL + '/api/auth/users/client';
  var myt = await storage.read(key: "jwt");
  final response = await http.get(Uri.parse(userListEndpoint),
      headers: {'Authorization': 'Bearer ' + myt.toString()});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var stores = json.decode(response.body);
    int len = stores.length;
    print('length = $len');
    return len;
  } else {
    throw Exception('Failed to load Users from API');
  }
}

Future<int> getLengthUsersNotVerified() async {
  final userListEndpoint = URL + '/api/auth/users/check/inactive';
  var myt = await storage.read(key: "jwt");

  final response = await http.get(Uri.parse(userListEndpoint),
      headers: {'Authorization': 'Bearer ' + myt.toString()});

  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var stores = json.decode(response.body);

    int len = stores.length;

    print('length = $len');
    return len;
  } else {
    throw Exception('Failed to load Users from API');
  }
}

Future<int> getLengthDemandes() async {
  final userListEndpoint = URL + '/api/demandes';
  var myt = await storage.read(key: "jwt");
  final response = await http.get(Uri.parse(userListEndpoint),
      headers: {'Authorization': 'Bearer ' + myt.toString()});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var stores = json.decode(response.body);
    int len = stores.length;
    print('length = $len');
    return len;
  } else {
    throw Exception('Failed to load Users from API');
  }
}
