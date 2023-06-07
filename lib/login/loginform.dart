import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../register/registerpage.dart';

import '../auth/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // ignore: unused_field
  final _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage = '';

  // print(emailController.text)

  //ignore: unused_element
  Future<void> signInWithEmailAndPassrod() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Email",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Your email id',
                labelStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 24.0),
          const Text(
            "Password",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: passwordController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            obscureText: true,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 31, 89)),
              onPressed: () {
                // Implement login functionality here
                signInWithEmailAndPassrod();
              },
              child: const Text(
                'Log in',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          InkWell(
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  style: TextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(text: "Don't have an account ?"),
                    TextSpan(
                        text: " Sign-up",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 1.0,
                width: 100.0,
                color: Colors.grey,
              ),
              const Text(
                "Or Login With",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 1.0,
                width: 100.0,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              //On Tap Login Here;
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("./lib/assets/googlelogo.png"),
                ),
              ],
            ),
          )
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // Implement Google authentication functionality here
          //   },
          //   icon: const Icon(Icons.login),
          //   label: const Text('Sign in with Google'),
          // ),
        ],
      ),
    );
  }
}
