// ignore: file_names
import "package:flutter/material.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallhaven/auth/widget_tree.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 6000));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const WidgetTree()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x000201c1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("./lib/assets/logo.png"),
                      fit: BoxFit.fill)),
              height: 400,
              width: 400,
              // color: Colors.blue,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              // color: Colors.blue,
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 30),
            )
            // ignore: avoid_unnecessary_containers
            // Container(
            //   child: const Text(
            //     'SplashScreen',
            //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
