import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '/models/categoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;



class CategoryProvider extends ChangeNotifier{


  TextEditingController txttitle = new TextEditingController();
  TextEditingController txtdesc = new TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();
  XFile? image_;

  List<CategoryDataModel> categorymodels = [];




  CategoryProvider(BuildContext ocntext){
    initRetrieval();
    notifyListeners();
  }

  String errorMessage = "";

  updateMessage(String a){
    errorMessage =a;
    notifyListeners();
  }



  getFromGallery() async {
    image_ = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  getFromCamera() async {
    image_ = await _picker.pickImage(source: ImageSource.camera);
    notifyListeners();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> initRetrieval() async {
    categorymodels = await  getCategories();
  }


  Future<List<CategoryDataModel>> getCategories() async{
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("categories").get();
    return snapshot.docs
        .map((docSnapshot) => CategoryDataModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  addCatgory(CategoryDataModel categoryDataModel) async {
    await _db.collection("categories").add(categoryDataModel.toMap());
    clearform();
  }


  deleteCatgory(String id) async {
    await _db.collection("categories").doc(id.toString()).delete();
  }


  clearform(){
     txtdesc.text="";
    txttitle.text="";
    image_ = null;
    notifyListeners();
  }


  uploadImageToStorage(XFile? pickedFile, CategoryDataModel model) async {
    if(kIsWeb){
      Reference _reference = storage
          .ref()
          .child('images/${Path.basename(pickedFile!.path)}');
      await _reference
          .putData(
        await pickedFile!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          model.imagepath= value.toString();
          addCatgory(model);
        });
      });
    }else{
//write a code for android or ios
    }

  }

}