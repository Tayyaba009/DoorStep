import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDataModel{
  //data Type
  String?  	id ;
  String?   date;
  String?   userid;
  String?   name;
  String?   d_address;
  String?   lati;
  String?   longi;
  String?   amount;
  String?   paytype;
  String?   dbid;
  String?   dbname;
  String?   status;

// constructor
  OrderDataModel(
      {
        required this.id,
        required this.date,
        required  this.userid,
        required  this.name,
        required  this.d_address,
        required  this.lati,
        required  this.longi,
        required  this.amount,
        required  this.paytype,
        required  this.dbid,
        required  this.dbname,
        required  this.status,
      }
      );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'userid': userid,
      'name': name,
      'd_address': d_address,
      'lati': lati,
      'longi': longi,
      'amount': amount,
      'paytype': paytype,
      'dbid': dbid,
      'dbname': dbname,
      'status': status,
    };
  }

  OrderDataModel.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        date = cat["date"],
        userid = cat["userid"],
        name = cat["name"],
        d_address = cat["d_address"],
        lati = cat["lati"],
        longi = cat["longi"],
        amount = cat["amount"],
        paytype = cat["paytype"],
        dbid = cat["dbid"],
        dbname = cat["dbname"],
        status = cat["status"];


  OrderDataModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        date = doc.data()!["date"],
        userid = doc.data()!["userid"],
        name = doc.data()!["name"],
        d_address = doc.data()!["d_address"],
        lati = doc.data()!["lati"],
        longi = doc.data()!["longi"],
        amount = doc.data()!["amount"],
        paytype = doc.data()!["paytype"],
        dbid = doc.data()!["dbid"],
        dbname = doc.data()!["dbname"],
        status = doc.data()!["status"];
}