import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raju_project1/admin/provider/DBoyProvider.dart';
import 'package:raju_project1/admin/provider/ProductProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raju_project1/admin/provider/vandorProvider.dart';
import 'package:raju_project1/models/dboy.dart';
import 'package:raju_project1/models/vandor_model.dart';
import '/models/productsDataModel.dart';
import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'dart:io';

class DBoyManagement extends StatefulWidget{

  _DBoyManagement createState() => new _DBoyManagement();
}

class _DBoyManagement extends State<DBoyManagement>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<DBoyProvider>(
        create: (_) => DBoyProvider(),
        child: Consumer<DBoyProvider>(
          builder: (context, model, child)=> Scaffold(


              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black87,
                title: Text("Delievry Boys", style: GoogleFonts.inter( color: Colors.white),),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('dboyes').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data = documents[index].data() as Map<String, dynamic>;





                          final pid =  documents[index].id.toString();// Replace 'title' with the field name in your Firestore documents
                          final email = data['email']; // Replace 'title' with the field name in your Firestore documents
                          final password = data['password']; // Replace 'title' with the field name in your Firestore documents
                          final name = data['name']; // Replace 'title' with the field name in your Firestore documents
                          final phonenumber = data['phonenumber']; // Replace 'title' with the field name in your Firestore documents
                          final city = data['city']; // Replace 'title' with the field name in your Firestore documents
                          final address = data['address']; // Replace 'title' with the field name in your Firestore documents
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
                                  lg: 2,
                                  xl: 2,
                                  xxl: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(email),
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
                                    child: Text(password),
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
                                  xs: 2,
                                  md: 2,
                                  lg: 2,
                                  xl: 2,
                                  xxl: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(phonenumber),
                                  ),
                                ),


                                BootstrapCol(
                                  xs: 2,
                                  md: 2,
                                  lg: 2,
                                  xl: 2,
                                  xxl:2,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(address),
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
                                    child: Text(city),
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
                child: Consumer<DBoyProvider>(
                  builder: (context,provider,child){
                    return FloatingActionButton(
                        onPressed: (){
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog( // <-- SEE HERE
                                title: Text('Add Delivery Boy'),
                                content: Column(
                                  children: [

                                    TextField(
                                      controller: provider.txtname,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),


                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtemail,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),


                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtpassword,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                      ),
                                    ),



                                    SizedBox(height: 8),
                                    TextField(
                                      controller: provider.txtcity,
                                      decoration: InputDecoration(
                                        labelText: 'City',
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
                                      controller: provider.txtphonenumber,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
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

                                      if(provider.txtname.text == ""){
                                        provider.updateMessage("Enter Vandor Name");
                                      }else if(provider.txtemail.text==""){
                                        provider.updateMessage("Enter Shop Name");
                                      } else if(provider.txtpassword.text == ""){
                                        provider.updateMessage("Enter Mobile No");
                                      } else if(provider.txtaddress.text == ""){
                                        provider.updateMessage("Enter Address ");
                                      }else {
                                       
                                        DBoy_Model model = new DBoy_Model(
                                            id: "",
                                            email: provider.txtemail.text,
                                            password: provider.txtpassword.text,
                                            name: provider.txtname.text,
                                            phonenumber: provider.txtphonenumber.text,
                                            city: provider.txtcity.text,
                                            address: provider.txtaddress.text,
                                            status: "Free"
                                        );
                                        provider.addDBoy(model);
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