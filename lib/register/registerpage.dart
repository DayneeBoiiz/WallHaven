import 'package:flutter/material.dart';
import 'package:wallhaven/register/registerform.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                "Sign up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 300.0,
            ),
            child: RegisterForm(),
          )
        ],
      ),
    );
  }
}
