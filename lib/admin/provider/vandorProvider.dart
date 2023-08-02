import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '/models/vandor_model.dart';
import 'package:flutter/material.dart';


class VandorProvider extends ChangeNotifier{



  TextEditingController txtvname = new TextEditingController();
  TextEditingController txtshopname = new TextEditingController();
  TextEditingController txtaddress = new TextEditingController();
  TextEditingController txtmobileno= new TextEditingController();
  TextEditingController txttype = new TextEditingController();

  List<Vendor_Model> vandorDataModel = [];

  FirebaseStorage storage = FirebaseStorage.instance;

  String errorMessage = "";

  updateMessage(String a){
    errorMessage =a;
    notifyListeners();
  }



  final FirebaseFirestore _db = FirebaseFirestore.instance;


  addVandor(Vendor_Model vendor_model) async {
    await _db.collection("vendors").add(vendor_model.toMap());
  }


  clearform(){
    txtvname.text="";
    txtshopname.text="";
    txtaddress.text= "";
    txtmobileno.text= "";
    txttype.text= "";
    notifyListeners();
  }

}