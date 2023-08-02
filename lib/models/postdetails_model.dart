import 'package:flutter/material.dart';

class PostDetails_Model {

  String id;
  String postid;
  String pid;
  String ptitle;
  String unitrate;
  String qnty;
  String totalamount;

  PostDetails_Model({
   required this.id,
   required this.postid,
   required this.pid,
   required this.ptitle,
   required this.unitrate,
     required this.qnty,
   required this.totalamount
  });

  factory PostDetails_Model.fromJson(Map<dynamic, dynamic> json) {
    return PostDetails_Model(
      id: json['id'].toString(),
      postid: json['postid'].toString(),
      pid: json['pid'].toString(),
      ptitle: json['ptitle'].toString(),
      unitrate: json['unitrate'].toString(),
      qnty: json['qnty'].toString(),
      totalamount: json['totalamount'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> posts = Map<String, dynamic>();
    posts["id"] = id;
    posts["postid"] = this.postid;
    posts["pid"] = this.pid;
    posts["ptitle"] = this.ptitle;
    posts["unitrate"] = this.unitrate;
    posts["qnty"] = this.qnty;
    posts["totalamount"] = this.totalamount;
    return posts;
  }

}

