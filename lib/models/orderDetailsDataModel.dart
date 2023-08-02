import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsDataModel{
  //data Type
  String? id;
  String? postid;
  String? pid;
  String? ptitle;
  String? unitrate;
  String?  qnty;
  String? totalamount;

  OrderDetailsDataModel(
      {
        required this.id,
        required this.postid,
        required  this.pid,
        required  this.ptitle,
        required  this.unitrate,
        required  this.qnty,
        required  this.totalamount,
      }
      );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postid': postid,
      'pid': pid,
      'ptitle': ptitle,
      'qnty': qnty,
      'totalamount': totalamount,
    };
  }

  OrderDetailsDataModel.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        postid = cat["postid"],
        pid = cat["pid"],
        ptitle = cat["ptitle"],
        qnty = cat["qnty"],
        totalamount = cat["totalamount"];


  OrderDetailsDataModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        postid = doc.data()!["postid"],
        pid = doc.data()!["pid"],
        ptitle = doc.data()!["ptitle"],
        qnty = doc.data()!["qnty"],
        totalamount = doc.data()!["totalamount"];
}