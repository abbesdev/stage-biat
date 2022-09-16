import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../../business_logic/apis/userApi.dart';

class AjouterReservation extends StatefulWidget {
  const AjouterReservation({Key? key}) : super(key: key);

  @override
  State<AjouterReservation> createState() => _AjouterReservationState();
}

TextEditingController typed = TextEditingController();

class _AjouterReservationState extends State<AjouterReservation> {
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Ecrire votre objet du demande",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
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
                      controller: typed,
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
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xffE64646)),
                        ),
                        disabledBorder: InputBorder.none,
                      ),
                      autofocus: true,
                      obscureText: true,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: height / 40,
          ),
          GestureDetector(
            onTap: (() => dPost(typed.text)),
            child: Container(
              width: width - 32,
              height: 70,
              decoration: BoxDecoration(
                  color: const Color(0xFF004579),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: const Text(
                "Ajouter Demande",
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.1),
              )),
            ),
          )
        ],
      )),
    );
  }

  Future<int> dPost(String typed) async {
    var myt = await storage.read(key: "jwt");
    var mytid = await storage.read(key: "userid");
    final testing = await http.post(
      Uri.parse(URL + '/api/demandes'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer ' + myt.toString()
      },
      body: jsonEncode(
          {"typeDemande": typed, "status": "Not Yet", "userid": mytid}),
    );
    print(testing.body);
    return testing.statusCode;
  }
}
