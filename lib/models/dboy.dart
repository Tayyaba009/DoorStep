import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBoy_Model {

  String id;
  String email;
  String password;
  String name;
  String phonenumber;
  String city;
  String address;
  String status;

  DBoy_Model({
   required   this.id,
    required  this.email,
    required  this.password,
    required  this.name,
    required  this.phonenumber,
    required  this.city,
    required  this.address,
    required  this.status,
   });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phonenumber': phonenumber,
      'city': city,
      'address': address,
      'status': status,
    };
  }

  DBoy_Model.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        email = cat["email"],
        password = cat["password"],
        name = cat["name"],
        phonenumber = cat["phonenumber"],
        city = cat["city"],
        address = cat["address"],
        status = cat["status"];


  DBoy_Model.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        email = doc.data()!["email"],
        password = doc.data()!["password"],
        name = doc.data()!["name"],
        phonenumber = doc.data()!["phonenumber"],
        city = doc.data()!["city"],
        address = doc.data()!["address"],
        status = doc.data()!["status"];


}

