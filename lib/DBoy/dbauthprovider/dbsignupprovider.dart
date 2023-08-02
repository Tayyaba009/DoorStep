import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class DBSignUpProvider extends ChangeNotifier {

  String responseMessage = "";
  final auth = FirebaseAuth.instance;
  TextEditingController txtname  =  new TextEditingController();
  TextEditingController txtusername  =  new TextEditingController();
  TextEditingController txtpassword  =  new TextEditingController();
  TextEditingController txtcpassword  =  new TextEditingController();

  void updateMessge(String message) {
    responseMessage = message;
    notifyListeners();
  }


  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName:name);

      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        updateMessge("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        updateMessge("The account already exists for that email.");
      } else if(e.code == 'invalid-email'){
        updateMessge("Email is Badly formatted please check your mail.");
      }  else if(e.code == "weak-password"){
        updateMessge("Weak Email Password let's try another.");
      }
    } catch (e) {
      updateMessge("Exception Occured."+e.toString());
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


