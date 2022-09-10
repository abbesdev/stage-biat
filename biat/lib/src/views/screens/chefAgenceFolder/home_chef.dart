import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../../business_logic/apis/userApi.dart';

class HomeChef extends StatefulWidget {
  const HomeChef({Key? key}) : super(key: key);

  @override
  State<HomeChef> createState() => _HomeChefState();
}

class _HomeChefState extends State<HomeChef> {
  void initState() {
    super.initState();
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                FutureBuilder(
                    future: _fetchAllUsers(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      return Text(
                        "Salut Mr. " + "${snapshot.data}" + " 👋,",
                        style: const TextStyle(
                            color: Color(0xFF979797),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.1),
                      );
                    })
              ],
            ),
          ),
          SizedBox(
            height: height / 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Prochains Rendez-vous",
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.1),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                GestureDetector(
                  child: Text(
                    "Voir plus",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFF08002),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 200,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                children: [Expanded(child: _rdvContainer())],
              )),
          SizedBox(
            height: height / 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Rendez-vous Finis",
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.1),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                GestureDetector(
                  child: Text(
                    "Voir plus",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFF08002),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height / 200,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                children: [Expanded(child: _rdvContainer())],
              )),
          SizedBox(
            height: height / 200,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(children: [
                Text(
                  "Calendrier du semaine",
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.1),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                GestureDetector(
                  child: Text(
                    "Voir plus",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFF08002),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        letterSpacing: 0.1),
                  ),
                )
              ])),
          SizedBox(
            height: height / 200,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: width / 6.5,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF004579)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width / 6.5,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color(0xFF004579), width: 1.5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width / 6.5,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color(0xFF004579), width: 1.5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width / 6.5,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color(0xFF004579), width: 1.5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width / 6.5,
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color(0xFF004579), width: 1.5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  ),
                ],
              ))
        ]),
      )),
    );
  }

  Widget _rdvContainer() {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  minRadius: 25,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text("abbes M.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text("Score :" + "900",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16,
                        )),
                  ],
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: width / 5,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search))
                  ],
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Color(0xFFF08002),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("5 Juillet",
                        style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ))
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Color(0xFFF08002),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("10am - 10.30am",
                        style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ))
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Color(0xFFF08002),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Sfax 2000",
                        style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ))
                  ],
                )
              ],
            )
          ],
        )
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
    print(jsonResponse['id']);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['fullname'];
    } else {
      throw Exception('Failed to load Users from API');
    }
  }
}
