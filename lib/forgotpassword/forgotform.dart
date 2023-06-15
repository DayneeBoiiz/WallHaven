import 'package:flutter/material.dart';
import 'package:wallhaven/login/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  // ignore: unused_field
  final _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  String? errorMessage = '';

  Future<void> resetPassword() async {
    final email = emailController.text;

    try {
      await Auth().resetPassword(email: email);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Route _loginRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 31, 89)),
              onPressed: () {
                // Implement login functionality here
                // registerWithEmailAndPassword();
                resetPassword();
              },
              child: const Text(
                'Sumbit',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(_loginRoute());
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: <TextSpan>[
                      TextSpan(text: "Back to"),
                      TextSpan(
                          text: " Login",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
          ),
        ]));
  }
}
