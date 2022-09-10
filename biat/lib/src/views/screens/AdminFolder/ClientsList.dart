import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/views/screens/AdminFolder/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../../business_logic/models/User.dart';
import 'HomeAdmin.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({Key? key}) : super(key: key);

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(1);
  }

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
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Liste des clients",
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
                    "voici les clients de votre application.",
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
          SizedBox(
            width: width - 32,
            child: DefaultTabController(
              length: 2,
              child: TabBar(controller: _tabController, tabs: [
                const Tab(
                    child: const Text(
                  'Not Verified',
                  style: TextStyle(color: Colors.black),
                )),
                const Tab(
                    child: const Text(
                  'Verified',
                  style: TextStyle(color: Colors.black),
                )),
              ]),
            ),
          ),
          SizedBox(
            height: height,
            child: TabBarView(controller: _tabController, children: [
              SizedBox(
                height: height,
                child: FutureBuilder<List<User>>(
                  future: _fetchAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<User>? data = snapshot.data;

                      return _usersListView(data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(
                child: FutureBuilder<List<User>>(
                  future: _fetchAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<User>? data = snapshot.data;
                      return _usersListView2(data);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                        width: 50, height: 50, child: Text("No Data"));
                  },
                ),
              )
            ]),
          )
        ]),
      )),
    );
  }
}

Future<List<User>> _fetchAllUsers() async {
  final userListEndpoint = URL + '/api/auth/users/client';
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

ListView _usersListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data[index].status == "inactive") {
          return GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetails(data[index].id)));
              }),
              child: _tile(data[index].fullname, data[index].cin,
                  data[index].status, Icons.work));
        } else {
          return SizedBox();
        }
      });
}

ListView _usersListView2(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data[index].status == "active") {
          return GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetails(data[index].id)));
              }),
              child: _tile(data[index].fullname, data[index].cin,
                  data[index].status, Icons.work));
        } else {
          return SizedBox();
        }
      });
}

ListTile _tile(
        String title, String subtitle, String subtitle2, IconData icon) =>
    ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle + " " + subtitle2),
        leading: Image.asset("assets/images/logo.png"));
