import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '/models/productsDataModel.dart';
import '/screens/productdetails.dart';
import '../../models/categoryDataModel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class ProductProvider extends ChangeNotifier{


  TextEditingController ptxttitle = new TextEditingController();
  TextEditingController ptxtdesc = new TextEditingController();
  TextEditingController ptxtcostprice = new TextEditingController();
  TextEditingController ptxtprice = new TextEditingController();
  TextEditingController ptxtqnty= new TextEditingController();
  TextEditingController ptxtdiscount = new TextEditingController();



  List<ProductDataModel> productmodels = [];


  FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();
  XFile? image_;


  ProductProvider(BuildContext ocntext){

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


  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> initRetrieval() async {
    productmodels = await  getProducts();
  }


  Future<List<ProductDataModel>> getProducts() async{
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("products").get();
    return snapshot.docs
        .map((docSnapshot) => ProductDataModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  addProduct(ProductDataModel productDataModel) async {
    await _db.collection("products").add(productDataModel.toMap());
  }


  addDelete(String doc) async {
    await _db.collection("products").doc(doc).delete();
  }


  clearform(){
    ptxttitle.text="";
    ptxtdesc.text="";
    image_ = null;
    notifyListeners();
  }


  uploadImageToStorage(XFile? pickedFile, ProductDataModel model) async {
    if(kIsWeb){
      Reference _reference = storage
          .ref()
          .child('products/${Path.basename(pickedFile!.path)}');
      await _reference
          .putData(
        await pickedFile!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          model.product_image= value.toString();
          addProduct(model);
        });
      });
    }else{
//write a code for android or ios
    }

  }

}