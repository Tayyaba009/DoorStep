import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User_Model {

  String id;
  String email;
  String password;
  String name;
  String phonenumber;
  String city;
  String address;

  User_Model({
   required   this.id,
    required   this.email,
    required   this.password,
    required   this.name,
    required  this.phonenumber,
    required  this.city,
    required  this.address,
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
    };
  }

  User_Model.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        email = cat["email"],
        password = cat["password"],
        name = cat["name"],
        phonenumber = cat["phonenumber"],
        city = cat["city"],
        address = cat["address"];


  User_Model.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        email = doc.data()!["email"],
        password = doc.data()!["password"],
        name = doc.data()!["name"],
        phonenumber = doc.data()!["phonenumber"],
        city = doc.data()!["city"],
        address = doc.data()!["address"];


}

