import 'dart:convert';

import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/business_logic/models/Agence.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../main.dart';
import 'package:http/http.dart' as http;

class Proceed extends StatefulWidget {
  const Proceed({Key? key}) : super(key: key);

  @override
  State<Proceed> createState() => _ProceedState();
}

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

bool error = false;
String message = "";

class _ProceedState extends State<Proceed> {
  String dropdownValue = 'client';
  String valueApi = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  children: [
                    Container(
                        width: width - 32,
                        child: const Text(
                          "Continuer l'inscription",
                          style: TextStyle(
                              color: Color(0xFF004579),
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              letterSpacing: 0.1),
                        ))
                  ],
                )),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  const Text(
                    "CIN",
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                        controller: name,
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
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xffE64646)),
                          ),
                          disabledBorder: InputBorder.none,
                        ),
                        autofocus: true,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  const Text(
                    "Type d'utilisateur",
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  Container(
                      width: width - 32,
                      height: 70,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        isExpanded: true,
                        elevation: 10,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['client', 'chef']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  const Text(
                    "Type d'agence",
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  SizedBox(
                      width: width - 40,
                      height: 70,
                      child: FutureBuilder<List<Agence>>(
                          future: _fetchAllAgences(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Agence>? data = snapshot.data;
                              return DropdownButton(
                                  hint: Text("Select agency"),
                                  isExpanded: true,
                                  items: data!.map((agence) {
                                    return DropdownMenuItem(
                                      child: Text(agence.agence),
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
            SizedBox(height: height / 3.5),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        int test = await userUpdate(
                            name.text, dropdownValue, valueApi);
                        if (test == 200) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("check your data again"),
                          ));
                        }
                      },
                      child: Container(
                        width: width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF004579),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: const Text(
                          "Inscription",
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
              ),
            ),
          ]),
        ),
      ),
    );
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
}
