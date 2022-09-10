import 'dart:convert';

import 'package:BiatRDV/main.dart';
import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/views/screens/AdminFolder/HomeAdmin.dart';
import 'package:BiatRDV/src/views/screens/WaitingScreen.dart';
import 'package:BiatRDV/src/views/screens/adherantFolder/Client.dart';
import 'package:BiatRDV/src/views/screens/chef_agence.dart';
import 'package:BiatRDV/src/views/screens/proceedRegister.dart';
import 'package:BiatRDV/src/views/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: height / 11,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: const [
                  Text(
                    "Bienvenue",
                    style: TextStyle(
                        color: Color(0xFF004579),
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
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
                      "Ouvrir votre compte pour reprendre votre experience dans le monde digital de reservation.",
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
              height: height / 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  const Text(
                    "Username",
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 60,
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
                        controller: username,
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
            SizedBox(
              height: height / 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 60,
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
                        controller: password,
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
                        obscureText: true,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: height / 40,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        }),
                        child: const Text(
                          "Mot de passe oublie ?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: const Color(0xFFF08002),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 0.1,
                          ),
                        )),
                  ],
                )),
            SizedBox(
              height: height / 6,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (() async {
                          var jwt = await login(username.text, password.text);
                          if (jsonDecode(jwt.body)['token'] != null) {
                            String token = await jsonDecode(jwt.body)['token'];
                            storage.write(key: "jwt", value: token);
                            var jwtt = await storage.read(key: "jwt");
                            var usertype =
                                await jsonDecode(jwt.body)['userType'];
                            var status = await jsonDecode(jwt.body)['status'];
                            storage.write(key: "usertype", value: usertype);

                            var userAgence =
                                await jsonDecode(jwt.body)['idAgence'];

                            storage.write(key: "userAgence", value: userAgence);
                            String userId =
                                await jsonDecode(jwt.body)['userid'];
                            storage.write(key: "userid", value: userId);
                            var userUID = await storage.read(key: "userid");
                            if (usertype == 'admin') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeAdmin()));
                            } else if (usertype == 'chef' &&
                                status == 'active') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChefAgence(jwtt!)));
                            } else if (usertype == 'client' &&
                                status == 'active') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Client(jwtt!)));
                            } else if (usertype == 'client' &&
                                status == 'inactive') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaitingScreen()));
                            } else if (usertype == 'chef' &&
                                status == 'inactive') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WaitingScreen()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Proceed()));
                            }
                          }
                        }),
                        child: Container(
                          width: width,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFF004579),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: const Text(
                            "Login",
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
                )),
            SizedBox(
              height: height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    }),
                    child: const Center(
                        child: const Text(
                      "Vous n'etes pas inscrit? Inscrivez vous",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFF08002),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.1,
                      ),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
