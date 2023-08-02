import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raju_project1/screens/intro_screen.dart';
import '../DBoy/db_dashboard.dart';
import '../admin/screens/adminlogin.dart';
import '../admin/screens/dashboard.dart';
import '../auth/login.dart';
import '/DBoy/dblogin.dart';
import '/screens/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
  //  PermissionsHandler.requestLocationPermission(context);

    // Create the animation controller and set the duration
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    // Create the animation using the controller
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Wait for the specified duration before navigating to the home page
    Timer(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()),);

    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            child: Center(
              child: FadeTransition(
                opacity: _animation,
                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            ),
        );
    }
}