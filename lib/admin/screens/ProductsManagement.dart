import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raju_project1/admin/provider/ProductProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/productsDataModel.dart';
import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'dart:io';

class AdminNewProduct extends StatefulWidget {
  _AdminNewProduct createState() => new _AdminNewProduct();
}

class _AdminNewProduct extends State<AdminNewProduct> {
  Future<void> fetchDropdownData() async {
    final data = await fetchDataFromFirestore();
    dropdownData = data;
  }

  List<String> dropdownData = [];
  String category = "";

  Future<List<String>> fetchDataFromFirestore() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
    List<String> dropdownData = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final dropdownValue = data['title']; // Replace with your field name
      dropdownData.add(dropdownValue);
    });
    return dropdownData;
  }

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<ProductProvider>(
        create: (_) => ProductProvider(context),
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black87,
              title: Text(
                "Products Management",
                style: GoogleFonts.inter(color: Colors.white),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('products').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final data = documents[index].data() as Map<String, dynamic>;

                        final pid = documents[index].id.toString();
                        final ptitle = data['product_name'];
                        final pdesc = data['product_description'];
                        final pprice = data['product_price'];
                        final pqnty = data['product_qunatity'];
                        final pimage = data['product_image'];
                        final pcostprice = data['product_costprice'];
                        final pcid = data['cid'];
                        final pdiscount = data['product_discount'];

                        return Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(5),
                          child: BootstrapRow(
                            horizontalSpacing: 5,
                            children: [
                              BootstrapCol(
                                xs: 2,
                                md: 2,
                                lg: 1,
                                xl: 1,
                                xxl: 1,
                                child: Image.network(
                                  pimage.toString(),
                                  width: 50,
                                  height: 50,
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
                                  child: Text(pdesc),
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
                                  child: Text(pprice),
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
                                  child: Text(pqnty),
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
                                  child: Text(pcostprice),
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
                                  child: Text(pcid),
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
                                  child: Text(pdiscount),
                                ),
                              ),
                              BootstrapCol(
                                xs: 2,
                                md: 2,
                                lg: 2,
                                xl: 2,
                                xxl: 2,
                                child: Consumer<ProductProvider>(
                                  builder: (context, provider, child) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          provider.addDelete(pid);
                                        },
                                        child: Text("Remove"),
                                      ),
                                    );
                                  },
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
            floatingActionButton: Container(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text('Add Product'),
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            provider.getFromGallery();
                                          },
                                          child: Center(
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              child: ClipOval(
                                                child: Semantics(
                                                  label: 'image_picker_example_picked_image',
                                                  child: provider.image_ == null
                                                      ? Container(
                                                    child: Image.asset("images/upload_image.png"),
                                                  )
                                                      : kIsWeb
                                                      ? Image.network(provider.image_!.path)
                                                      : Image.file(
                                                    File(
                                                      provider.image_!.path,
                                                    ),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          width: 400,
                                          child: DropdownButton<String>(
                                            value: category.isNotEmpty ? category : null,
                                            onChanged: (value) {
                                              setState(() {
                                                category = value!;
                                              });
                                            },
                                            items: dropdownData.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxttitle,
                                          decoration: InputDecoration(
                                            labelText: 'Product Title',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxtdesc,
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxtprice,
                                          decoration: InputDecoration(
                                            labelText: 'Price',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxtcostprice,
                                          decoration: InputDecoration(
                                            labelText: 'Cost Price',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxtqnty,
                                          decoration: InputDecoration(
                                            labelText: 'Quantity',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextField(
                                          controller: provider.ptxtdiscount,
                                          decoration: InputDecoration(
                                            labelText: 'Discount',
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: InputBorder.none, // Set the border to InputBorder.none
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          ProductDataModel model = new ProductDataModel(
                                            id: "",
                                            product_name: provider.ptxttitle.text,
                                            product_description: provider.ptxtdesc.text,
                                            product_price: provider.ptxtprice.text,
                                            product_qunatity: provider.ptxtqnty.text,
                                            product_image: "",
                                            product_costprice: provider.ptxtcostprice.text,
                                            cid: category.toString(),
                                            product_discount: provider.ptxtdiscount.text,
                                          );
                                          await provider.uploadImageToStorage(
                                            provider.image_,
                                            model,
                                          );
                                          provider.addProduct(model);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Add Product'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                }
                            ),
                          );
                        },
                      ).then((value) {
                        // This code will be executed after the dialog is closed
                        // Refresh the products list after adding a new product
                        productProvider.initRetrieval();
                      });
                    },
                    child: Icon(Icons.add, color: Colors.lightGreenAccent),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
