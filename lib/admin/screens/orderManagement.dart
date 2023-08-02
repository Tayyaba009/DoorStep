import 'dart:io';
import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:raju_project1/admin/provider/categoryprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/categoryDataModel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/orderprovider.dart';

class OrderManagement extends StatefulWidget{
  _OrderManagement createState() => new _OrderManagement();
}

class _OrderManagement extends State<OrderManagement>{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<OrderProvider>(
           create: (_) => OrderProvider(),
           child: Consumer<OrderProvider>(
           builder: (context, model, child)=> Scaffold(


             appBar: AppBar(
               elevation: 0,
               backgroundColor: Colors.black87,
               title: Text("Order Management", style: GoogleFonts.inter( color: Colors.white),),
               leading: IconButton(
                 icon: Icon(Icons.arrow_back, color: Colors.white,),
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
               ),
             ),
             body: Container(
             child: StreamBuilder<QuerySnapshot>(
               stream: FirebaseFirestore.instance.collection('orders').snapshots(),
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                   final List<DocumentSnapshot> documents = snapshot.data!.docs;

                   return ListView.builder(
                     itemCount: documents.length,
                     itemBuilder: (context, index) {
                       final data = documents[index].data() as Map<String, dynamic>;

                       final iid  = documents[index].id.toString();
                       final date = data['date']; // Replace 'title' with the field name in your Firestore documents
                       final userid = data['userid']; // Replace 'title' with the field name in your Firestore documents
                       final name = data['name']; // Replace 'title' with the field name in your Firestore documents
                       final d_address = data['d_address']; // Replace 'title' with the field name in your Firestore documents
                       final lati = data['lati']; // Replace 'title' with the field name in your Firestore documents
                       final longi = data['longi']; // Replace 'title' with the field name in your Firestore documents
                       final amount = data['amount']; // Replace 'title' with the field name in your Firestore documents
                       final paytype = data['paytype']; // Replace 'title' with the field name in your Firestore documents
                       final dbname = data['dbname']; // Replace 'title' with the field name in your Firestore documents
                       final dbid = data['dbid']; // Replace 'title' with the field name in your Firestore documents
                       final status = data['status']; // Replace 'title' with the field name in your Firestore documents


                       return Container(
                         color: Colors.white,
                         padding: EdgeInsets.all(5),
                         margin: EdgeInsets.all(5),
                         child:BootstrapRow(
                           horizontalSpacing: 5,
                           children: [

                             BootstrapCol(
                                 xs: 2,
                                 md: 2,
                                 lg: 1,
                                 xl: 1,
                                 xxl: 1,
                                 child:Image.network(iid.toString(),
                                   width: 50,
                                   height: 50,
                                 )
                             ),

                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 2,
                               xxl: 2,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(date),
                               ),
                             ),

                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 2,
                               xxl: 2,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(name),
                               ),
                             ),



                             BootstrapCol(
                               xs: 12,
                               md: 12,
                               lg: 6,
                               xl: 6,
                               xxl:6,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(d_address),
                               ),
                             ),


                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 1,
                               xxl: 1,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(amount),
                               ),
                             ),


                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 1,
                               xxl: 1,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(paytype),
                               ),
                             ),

                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 1,
                               xxl: 1,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(dbname),
                               ),
                             ),


                             BootstrapCol(
                               xs: 2,
                               md: 2,
                               lg: 2,
                               xl: 1,
                               xxl: 1,
                               child: Container(
                                 padding: EdgeInsets.all(5),
                                 child: Text(status),
                               ),
                             ),



                           ],
                         ),
                       );



                     },
                   );
                 }

                 if (snapshot.hasError) {
                   return Center(
                     child: Text('Error occurred: ${snapshot.error}'),
                   );
                 }

                 return Center(
                   child: CircularProgressIndicator(),
                 );
               },
             ),

           ),
             floatingActionButton:  Container(
               child: Consumer<CategoryProvider>(
                 builder: (context,provider,child){
                   return FloatingActionButton(
                       onPressed: (){
                         showDialog<void>(
                           context: context,
                           barrierDismissible: false, // user must tap button!
                           builder: (BuildContext context) {
                             return AlertDialog( // <-- SEE HERE
                               title: Text('Add Category'),
                               content: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [

                                   Container(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [


                                         SizedBox(
                                           height: 20,
                                         ),


                                         Center(
                                           child: Container(
                                             width: 120,
                                             height: 120,
                                             child: ClipOval(
                                               child: Semantics(
                                                 label: 'image_picker_example_picked_image',
                                                 child:provider.image_ == null ? Container(): kIsWeb
                                                     ? Image.network(provider.image_!.path)
                                                     : Image.file(File(provider.image_!.path,),
                                                   width: 150,
                                                   height: 150,
                                                   fit: BoxFit.fill,
                                                 ),
                                               ),

                                             ),
                                           ),
                                         ),
                                         SizedBox(
                                           height: 20,
                                         ),
                                         Center(
                                           child: ElevatedButton(
                                             onPressed: () async{
                                                 provider.getFromGallery();
                                             },
                                             child: Text("Upload Photo"),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   //-----------------------------------------------------------------------------


                                   SizedBox(
                                     height: 20,
                                   ),
                                   //-----------------------------------------------------------------------------

                                   TextField(
                                     controller: provider.txttitle,
                                     decoration: InputDecoration(
                                       labelText: 'Category Title',
                                       filled: true,
                                       fillColor: Colors.grey[200],
                                     ),
                                   ),
                                   SizedBox(height: 16),
                                   TextField(
                                     controller: provider.txtdesc,
                                     decoration: InputDecoration(
                                       labelText: 'Description',
                                       filled: true,
                                       fillColor: Colors.grey[200],
                                     ),
                                   ),
                                   SizedBox(height: 5),
                                   Container(
                                     margin:EdgeInsets.only(left:10),
                                     padding:EdgeInsets.all(10),
                                     child: Text("${provider.errorMessage.toString()}",
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.poppins(
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.red
                                       ),
                                     ),
                                   ),
                                   SizedBox(height: 16),

                                 ],
                               ),
                               actions: [
                                 ElevatedButton(
                                   onPressed: () async{
                                       CategoryDataModel model = new CategoryDataModel(
                                         id: "",
                                         title: provider.txttitle.text,
                                         description: provider.txtdesc.text,
                                         imagepath: ""
                                     );

                                     if(provider.txttitle.text == ""){
                                       provider.updateMessage("Enter Category Title");
                                       Fluttertoast.showToast(
                                           msg: "Enter Category Title",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.CENTER,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.red,
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                     } else if(provider.txtdesc.text==""){
                                       provider.updateMessage("Enter Category Description");
                                       Fluttertoast.showToast(
                                           msg: "Enter Category Description",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.CENTER,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.red,
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                     } else if(provider.image_ == null){
                                       provider.updateMessage("Select Image First");
                                       Fluttertoast.showToast(
                                           msg: "Select Image First",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.CENTER,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.red,
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                     } else {
                                      //  provider.addCatgory(model);
                                      await provider.uploadImageToStorage(provider.image_,model);
                                       Fluttertoast.showToast(
                                           msg: "Uploaded",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.CENTER,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.red,
                                           textColor: Colors.white,
                                           fontSize: 16.0
                                       );
                                     }
                                   },

                                   child: Text('Add Category'),
                                 ),
                                 ElevatedButton(
                                   onPressed: () {
                                     // Close the dialog box
                                     Navigator.of(context).pop();
                                   },
                                   child: Text('Cancel'),
                                 ),
                               ],
                             );
                           },
                         );
                       },
                       child: Icon(Icons.add));
                 },
               ),



             )
               ),
             ),
      ),
    );
  }
}