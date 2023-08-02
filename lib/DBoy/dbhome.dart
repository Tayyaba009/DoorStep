import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/orderDetailsHistory.dart';


class DBHomePage extends StatefulWidget{

  _DBHomePage createState()=> new _DBHomePage();
}
class _DBHomePage extends State<DBHomePage>{


  ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {

    return  Container(
                  color: Color(0xFFF5F5F5),
                  padding: EdgeInsets.all(5),
                  child: ListView(
                    controller: controller,
                    shrinkWrap: true,
                      children: [

                        //-------------------------------------------------------------------------------
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Your Orders", style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),),

                        ),

                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('orders').where("dbid",isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
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
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  OrderDetails(iid)),
                                        );
                                      },
                                      child: Container(
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
                        //-------------------------------------------------------------------------------
                      ]),

    );
  }
}