import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raju_project1/admin/provider/ProductProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raju_project1/admin/provider/vandorProvider.dart';
import 'package:raju_project1/models/vandor_model.dart';
import '/models/productsDataModel.dart';
import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'dart:io';

class VendorManagement extends StatefulWidget{

  _VendorManagement createState() => new _VendorManagement();
}

class _VendorManagement extends State<VendorManagement>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<VandorProvider>(
        create: (_) => VandorProvider(),
        child: Consumer<VandorProvider>(
          builder: (context, model, child)=> Scaffold(


              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black87,
                title: Text("Vendor Management", style: GoogleFonts.inter( color: Colors.white),),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data = documents[index].data() as Map<String, dynamic>;

                          final pid =  documents[index].id.toString();// Replace 'title' with the field name in your Firestore documents
                          final vname = data['vname']; // Replace 'title' with the field name in your Firestore documents
                          final shopname = data['shopname']; // Replace 'title' with the field name in your Firestore documents
                          final address = data['address']; // Replace 'title' with the field name in your Firestore documents
                          final mobileno = data['mobileno']; // Replace 'title' with the field name in your Firestore documents
                          final type = data['type']; // Replace 'title' with the field name in your Firestore documents

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
                                  lg: 2,
                                  xl: 2,
                                  xxl: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(vname),
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
                                    child: Text(shopname),
                                  ),
                                ),


                                BootstrapCol(
                                  xs: 2,
                                  md: 2,
                                  lg: 2,
                                  xl: 3,
                                  xxl:3,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(address),
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
                                    child: Text(mobileno),
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
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: (){},
                                      child: Text("Edit"),
                                    ),
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
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: (){},
                                      child: Text("Remove"),
                                    ),
                                  ),
                                ),



                              ],
                            ),
                          );
                            // Add more widgets here to display additional data from the Firestore document

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
                child: Consumer<VandorProvider>(
                  builder: (context,provider,child){
                    return FloatingActionButton(
                        onPressed: (){
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog( // <-- SEE HERE
                                title: Text('Add Vendor'),
                                content: Column(
                                  children: [


                              //-----------------------------------------------------------------------------


                              SizedBox(
                              height: 8,
                              ),
                              //-----------------------------------------------------------------------------

                                    TextField(
                                      controller: provider.txtvname,
                                      decoration: InputDecoration(
                                        labelText: 'Vendor Name',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),


                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtshopname,
                                      decoration: InputDecoration(
                                        labelText: 'Shop Name',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),


                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtaddress,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),



                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtmobileno,
                                      decoration: InputDecoration(
                                        labelText: 'Mobile No',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),



                                    SizedBox(height: 8),

                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {

                                      if(provider.txtvname.text == ""){
                                        provider.updateMessage("Enter Vandor Name");
                                      }else if(provider.txtshopname.text==""){
                                        provider.updateMessage("Enter Shop Name");
                                      } else if(provider.txtmobileno.text == ""){
                                        provider.updateMessage("Enter Mobile No");
                                      } else if(provider.txtaddress.text == ""){
                                        provider.updateMessage("Enter Address ");
                                      }else {
                                        Vendor_Model model = new Vendor_Model(
                                            id: "",
                                            vname: provider.txtvname.text,
                                            shopname: provider.txtshopname.text,
                                            address: provider.txtaddress.text,
                                            mobileno: provider.txtmobileno.text,
                                            type: provider.txttype.text
                                        );
                                        provider.addVandor(model);
                                      }
                                    },
                                    child: Text('Add Vendor'),
                                  ),
                                  TextButton(
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