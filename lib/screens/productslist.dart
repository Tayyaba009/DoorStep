import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../models/cartDataModel.dart';
import '/models/productsDataModel.dart';
import '/screens/productdetails.dart';

class ProductsListPage extends StatefulWidget{

  _ProductsListPage createState()=> new _ProductsListPage();
}
class _ProductsListPage extends State<ProductsListPage>{

  String selectedCategory = "All";
  String catname =  "All";



  ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {

    return  Container(
        color: Color(0xFFF5F5F0),
        padding: EdgeInsets.all(5),
        child: ListView(
          controller: controller,
          shrinkWrap: true,
          children: [

          //-------------------------------------------------------------------------------
      Container(
      height: 60,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            List categories = documents.map((document) {
              final data = document.data() as Map<String, dynamic>;
              final category = data['title'];
              return category;
            }).toList();

            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          category,
                          style: GoogleFonts.inter(
                            fontSize: selectedCategory == category ? 22 : 18,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == category ? Colors.black : Colors.grey[500],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Products", style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),),

            ),


            Container(
              child: catname == "All" ?  Container(
                child: defaultTargetPlatform  == TargetPlatform.android ? Container(
                  child:   Container(

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return GridView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing:7.0,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 0.25),
                            mainAxisSpacing: 7.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = snapshot.data!.docs[index];
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            String id  = document.id.toString();
                            String title = data['product_name'];
                            String imageUrl = data['product_image'];
                            String product_description = data['product_description'];
                            String product_costprice = data['product_costprice'];
                            String product_price = data['product_price'];
                            String product_qunatity = data['product_qunatity'];
                            String cid = data['cid'];
                            String product_discount = data['product_discount'];

                            return  GestureDetector(
                              onTap: (){
                                ProductDataModel ddd= new ProductDataModel(
                                    id: id,
                                    product_name: title,
                                    product_description: product_description,
                                    product_price: product_price,
                                    product_qunatity: product_qunatity,
                                    product_image: imageUrl,
                                    product_costprice: product_costprice,
                                    cid: cid,
                                    product_discount: product_discount);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ProductDetails(ddd)),
                                );
                              },

                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: GridTile(
                                  child: Container(

                                  ),
                                  footer: Column(
                                    children: [

                                      Image.network(imageUrl, fit: BoxFit.cover),


                                      Container(

                                        padding: EdgeInsets.all(3),
                                        child:  Text(title,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(

                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),),
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:EdgeInsets.only(right:30),
                                            child:  Text("RS / "+product_price,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(

                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),),
                                          ),

                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.black87,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.add, color: Colors.white, size: 20,),
                                              onPressed: (){
                                                CartDataModel model12  = new CartDataModel(
                                                    id: "",
                                                    p_id: id,
                                                    ptitle: title,
                                                    uprice: product_price,
                                                    qnty: "1",
                                                    tprice:product_price,
                                                    image: imageUrl
                                                );

                                                MyApp.Mcartlast.add(model12);
                                                Fluttertoast.showToast(
                                                    msg: "Item is added to cart",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),


                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ) :
                Container(
                  child:   Container(

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return GridView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing:7.0,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 0.35),
                            mainAxisSpacing: 7.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = snapshot.data!.docs[index];
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            String id  = document.id.toString();
                            String title = data['product_name'];
                            String imageUrl = data['product_image'];
                            String product_description = data['product_description'];
                            String product_costprice = data['product_costprice'];
                            String product_price = data['product_price'];
                            String product_qunatity = data['product_qunatity'];
                            String cid = data['cid'];
                            String product_discount = data['product_discount'];

                            return  GestureDetector(
                              onTap: (){
                                ProductDataModel ddd= new ProductDataModel(
                                    id: id,
                                    product_name: title,
                                    product_description: product_description,
                                    product_price: product_price,
                                    product_qunatity: product_qunatity,
                                    product_image: imageUrl,
                                    product_costprice: product_costprice,
                                    cid: cid,
                                    product_discount: product_discount);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ProductDetails(ddd)),
                                );
                              },

                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: GridTile(
                                  child: Container(

                                  ),
                                  footer: Column(
                                    children: [

                                      Image.network(imageUrl, fit: BoxFit.cover),


                                      Container(

                                        padding: EdgeInsets.all(3),
                                        child:  Text(title,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(

                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),),
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:EdgeInsets.only(right:30),
                                            child:  Text("RS / "+product_price,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(

                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),),
                                          ),

                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.black87,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.add, color: Colors.white, size: 20,),
                                              onPressed: (){


                                                CartDataModel model12  = new CartDataModel(
                                                    id: "",
                                                    p_id: id,
                                                    ptitle: title,
                                                    uprice: product_price,
                                                    qnty: "1",
                                                    tprice:product_price,
                                                    image: imageUrl
                                                );

                                                MyApp.Mcartlast.add(model12);
                                                Fluttertoast.showToast(
                                                    msg: "Item is added to cart",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
                  // ******************* -------------------------------  **************************//

                  :  Container(
                child: defaultTargetPlatform  == TargetPlatform.android ? Container(
                  child:   Container(

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').where("cid",isEqualTo:catname.toString()).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return GridView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing:7.0,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 0.25),
                            mainAxisSpacing: 7.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = snapshot.data!.docs[index];
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            String id  = document.id.toString();
                            String title = data['product_name'];
                            String imageUrl = data['product_image'];
                            String product_description = data['product_description'];
                            String product_costprice = data['product_costprice'];
                            String product_price = data['product_price'];
                            String product_qunatity = data['product_qunatity'];
                            String cid = data['cid'];
                            String product_discount = data['product_discount'];

                            return  GestureDetector(
                              onTap: (){
                                ProductDataModel ddd= new ProductDataModel(
                                    id: id,
                                    product_name: title,
                                    product_description: product_description,
                                    product_price: product_price,
                                    product_qunatity: product_qunatity,
                                    product_image: imageUrl,
                                    product_costprice: product_costprice,
                                    cid: cid,
                                    product_discount: product_discount);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ProductDetails(ddd)),
                                );
                              },

                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: GridTile(
                                  child: Container(

                                  ),
                                  footer: Column(
                                    children: [

                                      Image.network(imageUrl, fit: BoxFit.cover),


                                      Container(

                                        padding: EdgeInsets.all(3),
                                        child:  Text(title,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(

                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),),
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:EdgeInsets.only(right:30),
                                            child:  Text("RS / "+product_price,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(

                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),),
                                          ),

                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.black87,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.add, color: Colors.white, size: 20,),
                                              onPressed: (){
                                                CartDataModel model12  = new CartDataModel(
                                                    id: "",
                                                    p_id: id,
                                                    ptitle: title,
                                                    uprice: product_price,
                                                    qnty: "1",
                                                    tprice:product_price,
                                                    image: imageUrl
                                                );

                                                MyApp.Mcartlast.add(model12);
                                                Fluttertoast.showToast(
                                                    msg: "Item is added to cart",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),


                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ) :
                Container(
                  child: Container(

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').where("cid",isEqualTo:catname.toString()).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return GridView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            crossAxisSpacing:7.0,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 0.35),
                            mainAxisSpacing: 7.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = snapshot.data!.docs[index];
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            String id  = document.id.toString();
                            String title = data['product_name'];
                            String imageUrl = data['product_image'];
                            String product_description = data['product_description'];
                            String product_costprice = data['product_costprice'];
                            String product_price = data['product_price'];
                            String product_qunatity = data['product_qunatity'];
                            String cid = data['cid'];
                            String product_discount = data['product_discount'];

                            return  GestureDetector(
                              onTap: (){
                                ProductDataModel ddd= new ProductDataModel(
                                    id: id,
                                    product_name: title,
                                    product_description: product_description,
                                    product_price: product_price,
                                    product_qunatity: product_qunatity,
                                    product_image: imageUrl,
                                    product_costprice: product_costprice,
                                    cid: cid,
                                    product_discount: product_discount);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  ProductDetails(ddd)),
                                );
                              },

                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: GridTile(
                                  child: Container(

                                  ),
                                  footer: Column(
                                    children: [

                                      Image.network(imageUrl, fit: BoxFit.cover),


                                      Container(

                                        padding: EdgeInsets.all(3),
                                        child:  Text(title,
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.inter(

                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),),
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:EdgeInsets.only(right:30),
                                            child:  Text("RS / "+product_price,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.inter(

                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),),
                                          ),

                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.black87,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.add, color: Colors.white, size: 20,),
                                              onPressed: (){
                                                CartDataModel model12  = new CartDataModel(
                                                    id: "",
                                                    p_id: id,
                                                    ptitle: title,
                                                    uprice: product_price,
                                                    qnty: "1",
                                                    tprice:product_price,
                                                    image: imageUrl
                                                );

                                                MyApp.Mcartlast.add(model12);

                                                Fluttertoast.showToast(
                                                    msg: "Item is added to cart",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              },
                                            ),
                                          ),

                                        ],
                                      )

                                    ],
                                  ),


                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
                  // ******************* -------------------------------  **************************//

            )
            //-------------------------------------------------------------------------------
          ]),

    );
  }
}