import 'dart:convert';
import 'package:BiatRDV/src/business_logic/models/User.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

String URL = "http://localhost:8080";
get MyToken async {
  var jwtt = await storage.read(key: "jwt");

  return jwtt;
}

Future<int> userPost(String name, String email, String password) async {
  final testing = await http.post(
    Uri.parse(URL + '/api/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Connection': 'keep-alive'
    },
    body: jsonEncode({"fullname": name, "email": email, "password": password}),
  );
  print(testing.body);
  return testing.statusCode;
}

Future<int> userUpdate(String cin, String usertype, String idagence) async {
  var mytid = await storage.read(key: "userid");
  var myt = await storage.read(key: "jwt");
  final testing = await http.put(
    Uri.parse(URL + '/api/auth/user/' + mytid!),
    headers: {
      'Authorization': 'Bearer ' + myt.toString(),
      'Content-Type': 'application/json',
      'Connection': 'keep-alive'
    },
    body: jsonEncode({
      "cin": cin,
      "userType": usertype,
      "idAgence": idagence,
      "status": "inactive"
    }),
  );
  print(jsonEncode({"cin": cin, "userType": usertype, "idAgence": idagence}));
  print(testing.body);
  return testing.statusCode;
}

Future<http.Response> login(String username, String password) async {
  final testing = await http.post(
    Uri.parse(URL + '/api/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": username,
      "password": password,
    }),
  );
  final jsonResponse = json.decode(testing.body);

  String token = await jsonResponse['token'];

  print(testing);
  print(jsonResponse);
  print(jsonResponse['token']);
  print(jsonResponse['userType']);
  return testing;
}

Future<http.Response> loginUser(String username, String password) async {
  final testing = await http.post(
    Uri.parse(URL + '/api/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": username,
      "password": password,
    }),
  );
  final jsonResponse = json.decode(testing.body);
  print(jsonResponse['userid']);
  storage.write(key: 'useruuid', value: jsonResponse['userid']);
  return jsonResponse;
}

Future<List<User>> _fetchAllUsers() async {
  final userListEndpoint = '/api/users';
  final response = await http.get(Uri.parse(userListEndpoint));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => new User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load Users from API');
  }
}
