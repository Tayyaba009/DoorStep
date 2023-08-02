import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class OrderDetails extends StatefulWidget{
  String? id;

  OrderDetails(String a){
    id = a;
  }
  _OrderDetails createState() => new  _OrderDetails();
}

class _OrderDetails extends State<OrderDetails>{

  @override
  Widget build(BuildContext context) {

    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Row(
            children: [

              Text("Order Details",
               style: GoogleFonts.inter(
                 color: Colors.white
               ),
              )
            ],
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orderdetails').where("postid",isEqualTo: widget.id.toString()).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data = documents[index].data() as Map<String, dynamic>;

                          final iid  = documents[index].id.toString();
                          final date = data['date']; // Replace 'title' with the field name in your Firestore documents
                          final postid = data['postid']; // Replace 'title' with the field name in your Firestore documents
                          final pid = data['pid']; // Replace 'title' with the field name in your Firestore documents
                          final ptitle = data['ptitle']; // Replace 'title' with the field name in your Firestore documents
                          final unitrate = data['unitrate']; // Replace 'title' with the field name in your Firestore documents
                          final qnty = data['qnty']; // Replace 'title' with the field name in your Firestore documents
                          final totalamount = data['totalamount']; // Replace 'title' with the field name in your Firestore documents


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
                                      child: Text(ptitle),
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
                                      child: Text(unitrate),
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
                                      child: Text(qnty),
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
                                      child: Text(totalamount),
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

            ],
          ),
        ),

      ),

    );
  }
}

