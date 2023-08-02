import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataModel{
  //data Type
  String id;
  String product_name;
  String product_description;
  String product_price;
  String product_qunatity;
  String product_image;
  String product_costprice;
  String cid;
  String product_discount;


  ProductDataModel({
    required this.id,
    required  this.product_name,
    required this.product_description,
    required  this.product_price,
    required  this.product_qunatity,
    required  this.product_image,
    required  this.product_costprice,
    required this.cid,
    required this.product_discount
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': product_name,
      'product_description': product_description,
      'product_price': product_price,
      'product_qunatity': product_qunatity,
      'product_image': product_image,
      'product_costprice': product_costprice,
      'cid': cid,
      'product_discount': product_discount,
    };
  }

  ProductDataModel.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        product_name = cat["product_name"],
        product_description = cat["product_description"],
        product_price = cat["product_price"],
        product_qunatity = cat["product_qunatity"],
        product_image = cat["product_image"],
        product_costprice = cat["product_costprice"],
        cid = cat["cid"],
        product_discount = cat["product_discount"];


  ProductDataModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        product_name = doc.data()!["product_name"],
        product_description = doc.data()!["product_description"],
        product_price = doc.data()!["product_price"],
        product_qunatity = doc.data()!["product_qunatity"],
        product_image = doc.data()!["product_image"],
        product_costprice = doc.data()!["product_costprice"],
        cid = doc.data()!["cid"],
        product_discount = doc.data()!["product_discount"];


}