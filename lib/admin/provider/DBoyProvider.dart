import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raju_project1/models/dboy.dart';
import '/models/productsDataModel.dart';
import '/screens/productdetails.dart';
import '../../models/categoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class DBoyProvider extends ChangeNotifier{


  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtpassword = new TextEditingController();
  TextEditingController txtname = new TextEditingController();
  TextEditingController txtphonenumber = new TextEditingController();
  TextEditingController txtcity= new TextEditingController();
  TextEditingController txtaddress = new TextEditingController();
  TextEditingController txtstatus = new TextEditingController();

  List<DBoy_Model> productmodels = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  String errorMessage = "";

  updateMessage(String a){
    errorMessage =a;
    notifyListeners();
  }


  final FirebaseFirestore _db = FirebaseFirestore.instance;


  addDBoy(DBoy_Model dBoy_Model) async {
    await _db.collection("dboys").add(dBoy_Model.toMap());
    clearform();
  }


  clearform(){
    txtemail.text="";
    txtpassword.text="";
    txtname.text="";
    txtphonenumber.text="";
    txtcity.text="";
    txtaddress.text="";
    txtstatus.text="";

    notifyListeners();
  }

}