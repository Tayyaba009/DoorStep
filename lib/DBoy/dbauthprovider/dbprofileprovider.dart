import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '/models/dboy.dart';
import '/screens/dashboard.dart';
import '/models/user_model.dart';


class DBoyProvider extends ChangeNotifier {

  String deviceMAC = "";
  String createPorfileUri = "";
  DateTime? datetime;
  String responseMessage = "";
  String? dob;
  String? country;
  String? email;
  String? Uid;




  var dt = DateTime.now();

  TextEditingController txtfnameController = new TextEditingController();
  TextEditingController txtaddressController = new TextEditingController();
  TextEditingController txteducationController = new TextEditingController();
  TextEditingController txtcityController = new TextEditingController();
  TextEditingController txtphoneNumberController = new TextEditingController();
  XFile? image_;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String? clatitude;
  String? clongitude;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addDboy(DBoy_Model user_model, BuildContext context) async {
    await _db.collection("users").add(user_model.toMap());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashBoard()),
    );
    clearform();
  }

  clearform() {
    txtaddressController.text = "";
    txtcityController.text = "";
    txtfnameController.text = "";
    txtphoneNumberController.text = "";
    notifyListeners();
  }

  void updateMessge(String message) {
    responseMessage = message;
    notifyListeners();
  }
}
