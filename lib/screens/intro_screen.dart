import 'package:flutter/material.dart';
import 'package:raju_project1/auth/signup.dart';

import '../auth/login.dart';

void main() => runApp(IntroScreen());

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreenPage(),
    );
  }
}

class IntroScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/intro_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content in the center with left padding
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 210),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You can always order Products without leaving your home. Delivered Products to your doorstep.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 70),
                  Center(
                    child: Expanded( // Wrap the ElevatedButton with Expanded widget
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement the logic for "Sign in with Google" button
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Left align the icon and text
                          children: [
                            Image.asset(
                              'images/google_logo.png', // Replace with your Google icon image file path
                              height: 24, // Adjust the height of the icon
                              width: 24, // Adjust the width of the icon
                            ),
                            SizedBox(width: 8), // Add some space between the icon and text
                            Text(
                              'Sign in with Google',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        // Implement the logic for "Create Account" button
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 90),
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  GestureDetector(
                    child: Container(
                      width: screenWidth,
                      padding: EdgeInsets.all(10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account?  ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
