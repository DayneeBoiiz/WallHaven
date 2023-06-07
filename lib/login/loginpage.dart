import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import 'loginform.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_element
  // Future<void> _login() async {
  //   final email = emailController.text;
  //   final password = passwordController.text;

  //   final url = "http:localhost:9000/login";

  //   try {
  //     final response = await http
  //         .post(Uri.parse(url), body: {'email': email, 'password': password});

  //     if (response.statusCode == 200) {
  //       print('Login Successful');
  //     } else {
  //       print('Login Failed');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0x000201c1),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("./lib/assets/logo.png"),
                        fit: BoxFit.fill)),
                height: 200,
                width: 200,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    // left: 165,
                    bottom: 20,
                    // right: 20,
                    top: 245), //apply padding to some sides only
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 300.0),
              child: LoginForm(),
            )
          ],
        ));
  }
}
