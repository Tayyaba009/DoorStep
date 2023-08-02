import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/cartDataModel.dart';
import '/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb)
    await Firebase.initializeApp(

      options: FirebaseOptions(
          apiKey: "AIzaSyAJdY6oL1-lt44dsUKU86ploLpZV2tUVc8",
          authDomain: "hushburg1.firebaseapp.com",
          projectId: "hushburg1",
          storageBucket: "hushburg1.appspot.com",
          messagingSenderId: "538519397619",
          appId: "1:538519397619:web:f9fe6ff9c71dfa24450386",
          measurementId: "G-YGE9KNNSZK"
      ),
    );
  else{
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  static List<CartDataModel>  Mcartlast = [];
  static setName(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', a.toString());
  }


  static setEmail(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', a.toString());
  }


  static setAddress(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', a);
  }

  static setPhone(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', a);

  }


  static setUid(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', a);
  }


  static setCity(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', a);
  }


  static  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('name');
    return stringValue;
  }


  static  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('address');
    return stringValue;
  }


  static  getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('city');
    return stringValue;
  }

  static  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('email');
    return stringValue;
  }


  static  getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('phone');
    return stringValue;

  }


  static  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('uid');
    return stringValue;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Door Step',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
     home: SplashScreen(),
    );
  }
}

