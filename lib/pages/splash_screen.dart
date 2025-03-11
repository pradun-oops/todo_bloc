import 'package:flutter/material.dart';
import 'package:todo/contant/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToDoPage();
  }

  void goToDoPage() async {
    await Future.delayed(const Duration(seconds: 3));
    toDoPage();
  }

  void toDoPage() {
    Navigator.pushReplacementNamed(context, AppRoute.ROUTE_TODO_LIST_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/logo/logo.png", width: 350)],
        ),
      ),
    );
  }
}
