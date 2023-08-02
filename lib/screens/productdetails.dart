import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/productsDataModel.dart';
import '/models/cartDataModel.dart';
import '/main.dart';

class ProductDetails extends StatelessWidget{

  ProductDataModel? model;
  ProductDetails(ProductDataModel a){
    model =a;
  }

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
                  child: Image.network(model!.product_image,
                   fit: BoxFit.fill,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10, right: 20,top: 20, bottom: 10),
                  child:  Text("${model!.product_name}",
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    ),
                  ),
                ),



                Container(
                  padding: EdgeInsets.only(left: 10, right: 10,top: 5, bottom: 5),
                  child:  Text("${model!.product_description}",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black87
                    ),
                  ),
                ),



                Container(
                  child: Row(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left: 10, right: 1),
                        child: Image.asset("images/takka.png",
                          width: 40,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 1, right: 10,top: 10, bottom: 10),
                        child:  Text("${model!.product_price}",
                          style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        bottomSheet: Container(
          height: 65,

          child:    Container(
            width: swidth,
            height: 45,
            margin: EdgeInsets.only(left: 15, right: 15,top:5, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: (){
                CartDataModel model12  = new CartDataModel(
                    id: "",
                    p_id: model!.id,
                    ptitle: model!.product_name,
                    uprice: model!.product_price,
                    qnty: "1",
                    tprice:model!.product_price,
                    image: model!.product_image
                );

                MyApp.Mcartlast.add(model12);
              },
              child: Text("Add to cart",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}

