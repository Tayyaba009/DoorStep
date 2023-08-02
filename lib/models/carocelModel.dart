import 'package:flutter/material.dart';

class Carocel_Model {

  String o_id;
  String o_name;
  String o_image;
  String o_type;

  Carocel_Model({
    required  this.o_id,
    required this.o_name,
    required  this.o_image,
    required this.o_type
  });

  factory Carocel_Model.fromJson(Map<dynamic, dynamic> json) {
    return Carocel_Model(
      o_id: json['o_id'].toString(),
      o_name: json['o_name'].toString(),
      o_image: json['o_image'].toString(),
      o_type: json['o_type'].toString(),
    );
  }

}

