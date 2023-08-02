import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raju_project1/models/ordersModel.dart';
import '/models/productsDataModel.dart';
import '/screens/productdetails.dart';
import '../../models/categoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class OrderProvider extends ChangeNotifier{


  List<OrderDataModel> orderDatamodel = [];
  FirebaseStorage storage = FirebaseStorage.instance;

  OrderProvider(){

    notifyListeners();
  }

  String errorMessage = "";

  updateMessage(String a){
    errorMessage =a;
    notifyListeners();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

}