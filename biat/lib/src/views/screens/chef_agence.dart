import 'dart:convert';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/views/screens/chef_agence_home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChefAgence extends StatelessWidget {
  final String jwt;

  ChefAgence(this.jwt);

//bottom bar parametres

  @override
  Widget build(BuildContext context) {
    return ChefAgenceHome();
  }
}
