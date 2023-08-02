import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:raju_project1/admin/provider/categoryprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/categoryDataModel.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCategory extends StatefulWidget {
  _AdminCategory createState() => new _AdminCategory();
}

class _AdminCategory extends State<AdminCategory> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(context),
        child: Consumer<CategoryProvider>(
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black87,
              title: Text(
                "Categories List",
                style: GoogleFonts.inter(color: Colors.white),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final data = documents[index].data() as Map<String, dynamic>;
                        final iid = documents[index].id.toString();
                        final category = data['title']; // Replace 'title' with the field name in your Firestore documents
                        final imagee = data['imagepath']; // Replace 'title' with the field name in your Firestore documents
                        final desce = data['description']; // Replace 'title' with the field name in your Firestore documents

                        return ListTile(
                          title: Text(category),
                          subtitle: Text(desce),
                          leading: Image.network(
                            imagee.toString(),
                            fit: BoxFit.fill,
                            width: 50,
                            height: 50,
                          ),
                          trailing: Consumer<CategoryProvider>(
                            builder: (context, provider, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  provider.deleteCatgory(iid.toString());
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Set the background color to black
                                  onPrimary: Colors.white, // Set the text color to white
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0), // Rounded border
                                  ),
                                ),
                                child: Text("Remove"),
                              );

                            },
                          ),
                          // Add more widgets here to display additional data from the Firestore document
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
              child: Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  return FloatingActionButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
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
                                              child: provider.image_ == null
                                                  ? Container()
                                                  : kIsWeb
                                                  ? Image.network(provider.image_!.path)
                                                  : Image.file(
                                                File(
                                                  provider.image_!.path,
                                                ),
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
                                          onPressed: () async {
                                            provider.getFromGallery();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black, // Set the background color to black
                                            onPrimary: Colors.white, // Set the text color to white
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0), // Rounded border
                                            ),
                                          ),
                                          child: Text("Upload Photo"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //-----------------------------------------------------------------
                                SizedBox(
                                  height: 20,
                                ),
                                //-----------------------------------------------------------------------------

                                TextField(
                                  controller: provider.txttitle,
                                  decoration: InputDecoration(
                                    labelText: 'Category Title',
                                    filled: true,
                                    fillColor: Colors.grey[100], // Set the text field color to grey[100]
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Rounded border
                                      borderSide: BorderSide.none, // Remove the outline
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  controller: provider.txtdesc,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    filled: true,
                                    fillColor: Colors.grey[100], // Set the text field color to grey[100]
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Rounded border
                                      borderSide: BorderSide.none, // Remove the outline
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "${provider.errorMessage.toString()}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  CategoryDataModel model = new CategoryDataModel(
                                    id: "",
                                    title: provider.txttitle.text,
                                    description: provider.txtdesc.text,
                                    imagepath: "",
                                  );

                                  if (provider.txttitle.text == "") {
                                    provider.updateMessage("Enter Category Title");
                                    Fluttertoast.showToast(
                                      msg: "Enter Category Title",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else if (provider.txtdesc.text == "") {
                                    provider.updateMessage("Enter Category Description");
                                    Fluttertoast.showToast(
                                      msg: "Enter Category Description",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else if (provider.image_ == null) {
                                    provider.updateMessage("Select Image First");
                                    Fluttertoast.showToast(
                                      msg: "Select Image First",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    await provider.uploadImageToStorage(provider.image_, model);
                                    Fluttertoast.showToast(
                                      msg: "Uploaded",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Set the background color to black
                                  onPrimary: Colors.white, // Set the text color to white
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0), // Rounded border
                                  ),
                                ),
                                child: Text('Add Category'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Close the dialog box
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Set the background color to black
                                  onPrimary: Colors.white, // Set the text color to white
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0), // Rounded border
                                  ),
                                ),
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.black, // Set the background color to black
                    child: Icon(
                      Icons.add,
                      color: Colors.lightGreenAccent, // Set the icon color to light green accent
                    ),
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
