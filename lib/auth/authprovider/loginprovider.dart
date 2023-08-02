import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {

  String responseMessage = "";
  final auth = FirebaseAuth.instance;

  TextEditingController txtusername = new TextEditingController();
  TextEditingController txtpassword = new TextEditingController();


  void updateMessge(String message) {
    responseMessage = message;
    notifyListeners();
  }

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        responseMessage = "User Not Found In Correct Email.";
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        responseMessage = "Wrong password provided.";
        notifyListeners();
      } else if(e.code == 'invalid-email'){
        responseMessage = "Invalid Email Address.";
        notifyListeners();
      }
    }
    return user;
  }


  Future buildProgressDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: CupertinoActivityIndicator(
              animating: false,radius: 10
          ),
          content: Container(
            height: 25,
            child: Center(
                child: Text("Loading ...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
            ),
          ),
        );
      },
      context: context,
    );
  }


  Future buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            ElevatedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}


