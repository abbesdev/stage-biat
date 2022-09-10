import 'dart:convert';

import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/views/screens/AdminFolder/HomeAdmin.dart';
import 'package:BiatRDV/src/views/screens/WaitingScreen.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/Client.dart';
import 'package:BiatRDV/src/views/screens/chef_agence.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:BiatRDV/src/views/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<String?> get JwtOrEmpty async {
    var jwt = await storage.read(key: 'jwt');

    return jwt;
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (BuildContext context) {},
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Helvetica'),
            home: FutureBuilder(
                future: JwtOrEmpty,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var type = storage.read(key: "usertype");
                    var str = snapshot.data;
                    var jwt = str.toString().split(".");

                    if (type == 'admin') {
                    } else if (type == 'chef') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChefAgence(str.toString())));
                    } else if (type == 'client') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Client(str.toString())));
                    } else if (type == null && str.toString() != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaitingScreen()));
                    } else {
                      return const SignIn();
                    }
                  }
                  return SignIn();
                })));
  }
}
