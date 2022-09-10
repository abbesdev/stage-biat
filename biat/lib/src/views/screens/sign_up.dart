import 'package:BiatRDV/src/business_logic/apis/userApi.dart';
import 'package:BiatRDV/src/views/screens/proceedRegister.dart';
import 'package:BiatRDV/src/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _SignUpState extends State<SignUp> {
  String dropdownValue = 'user';
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
                const SizedBox(
                  height: 80,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Row(
                      children: [
                        Container(
                            width: width - 32,
                            child: const Text(
                              "Bienvenue",
                              style: TextStyle(
                                  color: Color(0xFF004579),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                  letterSpacing: 0.1),
                            ))
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: const Text(
                        "Creer votre compte pour demarrer votre experience dans le monde digital de reservation.",
                        style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.1),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Nom et Prenom",
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
                  height: 20,
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
                        "Email",
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
                  height: 20,
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
                            controller: email,
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
                        "Password",
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
                  height: 20,
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
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            int test = await userPost(
                                name.text, email.text, password.text);
                            if (test == 200) {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                                  builder: (context) => const SignIn()));
                        }),
                        child: const Center(
                            child: const Text(
                          "Vous etes inscrit? Login",
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
              ]),
        ),
      ),
    );
  }
}
