import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/models/Demande.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/AjouterReservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../../business_logic/apis/userApi.dart';

class DemandeClient extends StatefulWidget {
  const DemandeClient({Key? key}) : super(key: key);

  @override
  State<DemandeClient> createState() => _DemandeClientState();
}

class _DemandeClientState extends State<DemandeClient> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AjouterReservation()));
                                  },
                                  child: Expanded(
                                    child: Container(
                                      width: width / 1.2,
                                      height: 60,
                                      color: Colors.blue,
                                      child: Center(
                                          child: Text(
                                        'Ajouter une demande',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ))
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 16),
                        child: Row(
                          children: [
                            Text(
                              "Liste des demandes",
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 0.1),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 200,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 16),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: width - 32,
                                  height: height / 1.5,
                                  child: FutureBuilder<List<Demande>>(
                                      future: _fetchAllDemandes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Demande>? data = snapshot.data;
                                          return _rdvListView(data);
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return Container(
                                          child: Text("no data"),
                                        );
                                      }))
                            ],
                          )),
                    ]))));
  }

  Future<List<Demande>> _fetchAllDemandes() async {
    var mytid = await storage.read(key: "userid");

    final userListEndpoint = URL + '/api/demande/' + mytid!;
    var myt = await storage.read(key: "jwt");

    final response = await http.get(Uri.parse(userListEndpoint),
        headers: {'Authorization': 'Bearer ' + myt.toString()});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((demande) => new Demande.fromJson(demande))
          .toList();
    } else {
      throw Exception('Failed to load Users from API');
    }
  }

  ListView _rdvListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: _rdvContainer(data[index].typeDemande, data[index].status),
          );
        });
  }

  Widget _rdvContainer(String typeDemande, String status) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height / 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.black),
          color: Color(0xFF004579).withOpacity(0.02)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width / 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(typeDemande,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        )),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Text(status,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16,
                        )),
                  ],
                )
              ],
            ),
            Spacer(),
            Column(
              children: [Icon(Icons.arrow_forward)],
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
      ]),
    );
  }
}
