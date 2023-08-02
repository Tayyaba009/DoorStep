import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/admin/provider/DBoyProvider.dart';
import '/models/dboy.dart';
import '/auth/authprovider/authprovider.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget{
  String? uid;
  String? email;
  _CreateAccount createState() => new _CreateAccount();
}

class _CreateAccount extends State<CreateAccount>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int bottomSelectedIndex = 0;

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    double sc_width =  MediaQuery.of(context).size.width;
    double sc_height =  MediaQuery.of(context).size.height;

    return  ChangeNotifierProvider(
      create: (_) => AuthProvider(widget.uid.toString(),widget.email.toString()),
      child: Consumer<AuthProvider>(
          builder: (context,model,child)=> MaterialApp(
            home: Scaffold(
                body: Center(
                  //color: Colors.white,
                  child: Consumer<DBoyProvider>(
                      builder: (context,provider, child){
                        return ListView(
                          shrinkWrap: true,
                          children: [


                            Container(
                              width: sc_width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Container(
                                    margin:EdgeInsets.only(left:15,bottom: 20),
                                    padding:EdgeInsets.all(5),
                                    child: Text("Delievry Boy Profile",
                                      style: GoogleFonts.poppins(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),



                                  Container(
                                    margin:EdgeInsets.only(left:15),
                                    padding:EdgeInsets.all(5),
                                    child: Text("Enter First Name",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin:EdgeInsets.only(left:15, right: 15),
                                    padding:EdgeInsets.all(5),
                                    child: TextFormField(
                                      controller: provider.txtname,
                                      decoration: new InputDecoration(
                                        labelText: "Enter First Name",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                          ),
                                        ),
                                      ),
                                      validator:  (val) {
                                        if(val?.length ==0) {
                                          return "First Name cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //---------------------------------------------------------------------------------

                            Container(
                              width: sc_width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    margin:EdgeInsets.only(left:15),
                                    padding:EdgeInsets.all(5),
                                    child: Text("Enter Phone Number",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin:EdgeInsets.only(left:15, right: 15),
                                    padding:EdgeInsets.all(5),
                                    child: TextFormField(
                                      controller: provider.txtphonenumber,
                                      decoration: new InputDecoration(
                                        labelText: "Enter Phone Number",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                          ),
                                        ),
                                      ),
                                      validator:  (val) {
                                        if(val?.length ==0) {
                                          return "Phone Number cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //---------------------------------------------------------------------------------

                            Container(
                              width: sc_width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    margin:EdgeInsets.only(left:15),
                                    padding:EdgeInsets.all(5),
                                    child: Text("Enter City",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin:EdgeInsets.only(left:15, right: 15),
                                    padding:EdgeInsets.all(5),
                                    child: TextFormField(
                                      controller: provider.txtcity,
                                      decoration: new InputDecoration(
                                        labelText: "Enter City",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                          ),
                                        ),
                                      ),
                                      validator:  (val) {
                                        if(val?.length ==0) {
                                          return "City Name cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //---------------------------------------------------------------------------------

                            Container(
                              width: sc_width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    margin:EdgeInsets.only(left:10),
                                    padding:EdgeInsets.all(10),
                                    child: Text("Enter Address",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin:EdgeInsets.only(left:10),
                                    padding:EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: provider.txtaddress,
                                      decoration: new InputDecoration(
                                        labelText: "Enter Address",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                          ),
                                        ),
                                      ),
                                      validator:  (val) {
                                        if(val?.length ==0) {
                                          return "Address cannot be empty";
                                        }else{
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //---------------------------------------------------------------------------------
                            Container(
                              width: sc_width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                      width: sc_width -50,
                                      height: 70,
                                      margin:EdgeInsets.only(left:10),
                                      padding:EdgeInsets.all(10),
                                      child: ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff00A36C),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),

                                        onPressed: (){

                                          DBoy_Model model = new DBoy_Model(
                                              id: FirebaseAuth.instance.currentUser!.uid.toString(),
                                              email: FirebaseAuth.instance.currentUser!.email.toString(),
                                              password: "",
                                              name: provider.txtname.text,
                                              phonenumber:provider.txtphonenumber.text,
                                              city: provider.txtcity.text,
                                              address: provider.txtaddress.text,
                                              status: "Unregistered"
                                          );




                                          buildProgressDialog(context);
                                          provider.addDBoy(model) ;
                                        },
                                        child: Text("Register",
                                          style:  GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),

                            //--------------------------------------------------------------------------------------

                          ],
                        );
                      }
                  ),
                )
            ),
          )
      ),
    );

  }


  Future buildProgressDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: CupertinoActivityIndicator(
              animating: false,radius: 10
          ),
          content: Container(
            height: 25,
            child: Center(
                child: Text("Account Creating Please Wait",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
            ),
          ),
        );
      },
      context: context,
    );
  }

  void settingModalBottomSheet(context){

  }
//--------------------------------------------------------------------------------
}
