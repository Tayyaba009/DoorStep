import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDataModel{
  //data Type
  String id;
  String title;
  String description;
  String imagepath;

// constructor
  CategoryDataModel(
      {
       required this.id,
        required this.title,
        required  this.description,
        required  this.imagepath,
      }
      );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagepath': imagepath,
    };
  }

  CategoryDataModel.fromMap(Map<String, dynamic> cat)
      : id = cat["id"],
        title = cat["title"],
        description = cat["description"],
        imagepath = cat["imagepath"];


  CategoryDataModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!["title"],
        description = doc.data()!["description"],
        imagepath = doc.data()!["imagepath"];
}