import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../business_logic/apis/userApi.dart';
import '../../../business_logic/models/Agence.dart';
import 'ClientsList.dart';
import 'HomeAdmin.dart';

class AgencesList extends StatefulWidget {
  const AgencesList({Key? key}) : super(key: key);

  @override
  State<AgencesList> createState() => _AgencesListState();
}

TextEditingController agenceController = TextEditingController();

class _AgencesListState extends State<AgencesList> {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeAdmin()));
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
                      MaterialPageRoute(builder: (context) => HomeAdmin()));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt),
                title: const Text('Liste des agences'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                    child: Row(
                      children: [
                        Text(
                          "Liste des Agences",
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
                            "voici les agences disponibles de votre application.",
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
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: width,
                            height: height / 1.6,
                            child: FutureBuilder<List<Agence>>(
                              future: _fetchAllAgences(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Agence>? data = snapshot.data;
                                  return _agencesListView(data);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Container(
                                    width: 50,
                                    height: 50,
                                    child: Text("No Data"));
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Ajouter une agence :'),
                                        Container(
                                            width: width - 32,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF2F3F5),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextFormField(
                                              controller: agenceController,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    const Color(0xfffaebeb),
                                                contentPadding:
                                                    const EdgeInsets.all(25),
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Color(0xFF004579)),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black12,
                                                      width: 1),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffE64646)),
                                                ),
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                              autofocus: true,
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            agencePost(agenceController.text);
                                          },
                                          child: Container(
                                            width: width,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF004579),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                                child: const Text(
                                              "Ajouter une agence",
                                              style: const TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  letterSpacing: 0.1),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xFF004579),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: const Text(
                              "Ajouter une agence",
                              style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  letterSpacing: 0.1),
                            )),
                          ),
                        ),
                      )
                    ],
                  )
                ]))));
  }

  Future<List<Agence>> _fetchAllAgences() async {
    final userListEndpoint = URL + '/api/agences';
    var myt = await storage.read(key: "jwt");
    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    String totalChefs = response.body.length.toString();
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((agence) => new Agence.fromJson(agence)).toList();
    } else {
      throw Exception('Failed to load Users from API');
    }
  }

  ListView _agencesListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: (() {
                /*    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetails(data[index].id))); */
              }),
              child: _tile(data[index].agence, data[index].id, Icons.work));
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Image.asset("assets/images/logo.png"));

  Future<int> agencePost(String agence) async {
    var myt = await storage.read(key: "jwt");
    final testing = await http.post(
      Uri.parse(
        URL + '/api/agences/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + myt.toString()
      },
      body: jsonEncode({
        "agence": agence,
      }),
    );
    print(testing.body);
    return testing.statusCode;
  }
}
