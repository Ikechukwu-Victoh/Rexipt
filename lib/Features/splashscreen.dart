import 'package:flutter/material.dart';
import 'package:rexipt/Widgets/bottomnavbar_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 3, 124),
      body: Center(child: Image.asset('assets/images/Frame 1.png')),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: 4));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomnavbarScreen()),
    );
  }
}
