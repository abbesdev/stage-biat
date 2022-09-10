import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../business_logic/apis/userApi.dart';
import '../../../business_logic/models/User.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  UserDetails(this.useruid, {Key? key}) : super(key: key);
  var useruid;
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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
          Row(
            children: [
              FutureBuilder(
                future: _fetchAllUsers('${widget.useruid}'),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) return Text('${snapshot.error}');
                  if (snapshot.hasData)
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${snapshot.data['id']}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.1),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${snapshot.data['fullname']}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.1),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${snapshot.data['cin']}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.1),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${snapshot.data['status']}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.1),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  _verifyUser('${widget.useruid}');
                                },
                                child: Container(
                                  width: width - 32,
                                  height: 70,
                                  color: Colors.blue,
                                  child: Center(
                                      child: Text(
                                    "Accepter",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ))
                          ],
                        )
                      ],
                    );
                  return const CircularProgressIndicator();
                },
              )
            ],
          )
        ],
      )),
    );
  }

  _fetchAllUsers(useruid) async {
    final userListEndpoint = URL + '/api/auth/user/' + useruid;
    var myt = await storage.read(key: "jwt");
    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});
    var jsonResponse = json.decode(response.body);
    print(jsonResponse['email']);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load Users from API');
    }
  }
}

_verifyUser(useruid) async {
  final userListEndpoint = URL + '/api/auth/user/' + useruid;
  var myt = await storage.read(key: "jwt");
  final response = await http.put(Uri.parse(userListEndpoint),
      headers: {
        'Authorization': 'Bearer ' + myt.toString(),
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      body: jsonEncode({"status": "active"}));

  print(response.body);
  print(response.statusCode);
}
