import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '/main.dart';
import '/models/cartDataModel.dart';
import '/models/productsDataModel.dart';
import '/screens/productdetails.dart';

class HomePage extends StatelessWidget {
  final List<String> imgList = [""
      "images/shp1.png",
    "images/shp2.png"];
  int _current = 0; // For tracking the current index of the carousel

  ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0), // Add desired right and left padding
    child: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.all(3),
        child: ListView(
          controller: controller,
          shrinkWrap: true,
          children: [
            CarouselSliderWidget(imgList: imgList, onIndexChanged: (index) => _current = index, controller: controller),
            Container(
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 0.0, 5.0),
              child: Text(
                "Categories",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CategoriesGrid(controller: controller),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Products",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProductsGrid(controller: controller),
          ],
        ),
      ),
    ),
    );
  }
}

class CarouselSliderWidget extends StatefulWidget {
  final List<String> imgList;
  final ValueChanged<int> onIndexChanged;
  final ScrollController controller;

  CarouselSliderWidget({required this.imgList, required this.onIndexChanged, required this.controller});

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            itemCount: widget.imgList.length,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                widget.onIndexChanged(index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final imageUrl = widget.imgList[index];
              return Container(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 1300,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.map((url) {
              int index = widget.imgList.indexOf(url);
              return Container(

                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.lightGreenAccent : Colors.white,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
class CategoriesGrid extends StatelessWidget {
  final ScrollController controller;

  CategoriesGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
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
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String title = data['title'];
              String imageUrl = data['imagepath'];

              return GestureDetector(
                onTap: () {
                  // Handle tap on the grid item
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0), // Add the desired right and left padding here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        title,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final ScrollController controller;

  ProductsGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: defaultTargetPlatform == TargetPlatform.android
            ? Container(
          child: Container(
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
                    crossAxisSpacing: 7.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 0.25),
                    mainAxisSpacing: 7.0,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String id = document.id.toString();
                    String title = data['product_name'];
                    String imageUrl = data['product_image'];
                    String product_description = data['product_description'];
                    String product_costprice = data['product_costprice'];
                    String product_price = data['product_price'];
                    String product_qunatity = data['product_qunatity'];
                    String cid = data['cid'];
                    String product_discount = data['product_discount'];

                    return GestureDetector(
                      onTap: () {
                        ProductDataModel ddd = new ProductDataModel(
                          id: id,
                          product_name: title,
                          product_description: product_description,
                          product_price: product_price,
                          product_qunatity: product_qunatity,
                          product_image: imageUrl,
                          product_costprice: product_costprice,
                          cid: cid,
                          product_discount: product_discount,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetails(ddd)),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: GridTile(
                          child: Container(),
                          footer: Column(
                            children: [
                              SizedBox(
                                height: 80, // Set the desired height for the product container
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "RS / $product_price",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Colors.black87,
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        CartDataModel model12 = new CartDataModel(
                                          id: "",
                                          p_id: id,
                                          ptitle: title,
                                          uprice: product_price,
                                          qnty: "1",
                                          tprice: product_price,
                                          image: imageUrl,
                                        );

                                        MyApp.Mcartlast.add(model12);
                                        Fluttertoast.showToast(
                                          msg: "Item is added to cart",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
        )
            : Container(
          child: Container(
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
                    crossAxisSpacing: 7.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 0.35),
                    mainAxisSpacing: 7.0,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String id = document.id.toString();
                    String title = data['product_name'];
                    String imageUrl = data['product_image'];
                    String product_description = data['product_description'];
                    String product_costprice = data['product_costprice'];
                    String product_price = data['product_price'];
                    String product_qunatity = data['product_qunatity'];
                    String cid = data['cid'];
                    String product_discount = data['product_discount'];

                    return GestureDetector(
                      onTap: () {
                        ProductDataModel ddd = new ProductDataModel(
                          id: id,
                          product_name: title,
                          product_description: product_description,
                          product_price: product_price,
                          product_qunatity: product_qunatity,
                          product_image: imageUrl,
                          product_costprice: product_costprice,
                          cid: cid,
                          product_discount: product_discount,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetails(ddd)),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: GridTile(
                          child: Container(),
                          footer: Column(
                            children: [
                              SizedBox(
                                height: 80, // Set the desired height for the product container
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "RS / $product_price",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Colors.black87,
                                    ),
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        CartDataModel model12 = new CartDataModel(
                                          id: "",
                                          p_id: id,
                                          ptitle: title,
                                          uprice: product_price,
                                          qnty: "1",
                                          tprice: product_price,
                                          image: imageUrl,
                                        );

                                        MyApp.Mcartlast.add(model12);
                                        Fluttertoast.showToast(
                                          msg: "Item is added to cart",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
        );
  }
}
