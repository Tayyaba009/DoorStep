import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vendor_Model {

  String id;
  String vname;
  String shopname;
  String address;
  String mobileno;
  String type;


  Vendor_Model({
    required this.id,
    required this.vname,
    required this.shopname,
    required this.address,
    required this.mobileno,
    required this.type
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vname': vname,
      'shopname': shopname,
      'address': address,
      'mobileno': mobileno,
      'type': type,
    };
  }

  Vendor_Model.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        vname = cat["vname"],
        shopname = cat["shopname"],
        address = cat["address"],
        mobileno = cat["mobileno"],
        type = cat["type"];


  Vendor_Model.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        vname = doc.data()!["vname"],
        shopname = doc.data()!["shopname"],
        address = doc.data()!["address"],
        mobileno = doc.data()!["mobileno"],
        type = doc.data()!["type"];



}

