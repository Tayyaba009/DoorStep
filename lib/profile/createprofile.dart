import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'createprofileProvider.dart';

class CreateProfile extends StatefulWidget{

  _CreateProfile createState() => new _CreateProfile();
}

class _CreateProfile extends State<CreateProfile>{

  @override
  Widget build(BuildContext context) {
    double sc_width =  MediaQuery.of(context).size.width;
    double sc_height =  MediaQuery.of(context).size.height;

    return  ChangeNotifierProvider<CreateProvider>(
        create:  (_) => CreateProvider(),
        child: Consumer<CreateProvider>(
        builder: (context,model,child){

          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text("Set Up Profile"),
              ),
              body: Center(
              child: ListView(
                children: [

                  Consumer<CreateProvider>(
                    builder: (context,provider,child){
                      return ListView(
                        shrinkWrap: true,
                        children: [

                          Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(

                                      padding: EdgeInsets.only(left: 10,bottom: 50, top: 2),
                                      child: Text("SetUp Profile",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.inter(
                                            fontSize: 32,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),





                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(

                                      padding: EdgeInsets.only(left: 10,bottom: 2, top: 2),
                                      child: Text("Enter Name",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(

                                        padding: EdgeInsets.only(left: 10,bottom: 5, top: 5),
                                        child: TextField(
                                          controller: provider.txtname,
                                          decoration: new InputDecoration(
                                            labelText: "Name",
                                            prefixIcon: Icon(Icons.person),
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(10.0),
                                              borderSide: new BorderSide(
                                              ),
                                            ),
                                            //fillColor: Colors.green
                                          ),
                                        )
                                    ),
                                  ),
                                ),


                                //---------------------------------------------------------------------------------

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10,bottom: 3, top: 3),
                                      child: Text("Email",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.only(left: 10,bottom: 2, top: 2),
                                        child: TextField(
                                           controller: provider.txtemail,
                                          decoration: new InputDecoration(
                                            labelText: "Enter Email",
                                            prefixIcon: Icon(Icons.email),
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(10.0),
                                              borderSide: new BorderSide(
                                              ),
                                            ),
                                            //fillColor: Colors.green
                                          ),
                                        )
                                    ),
                                  ),
                                ),

                                //------------------------------------------------------------------------------------
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10,bottom: 2, top: 2),
                                      child: Text("Mobile Number",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [

                                      //-----------------------------------------------------------

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:  Expanded(
                                          child: Container(
                                              width: sc_width * .6,
                                              padding: EdgeInsets.only(left: 0,bottom: 3, top: 3),
                                              child: TextField(
                                                controller: provider.txtphoneno,
                                                decoration: new InputDecoration(
                                                  labelText: "Mobile Number",
                                                  fillColor: Colors.white,
                                                  border: new OutlineInputBorder(
                                                    borderRadius: new BorderRadius.circular(10.0),
                                                    borderSide: new BorderSide(
                                                    ),
                                                  ),
                                                  //fillColor: Colors.green
                                                ),
                                              )
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),

                                //--------------------------------------------------------------------------------------------------------
                                Container(
                                  child: Row(
                                    children: [

                                      Container(
                                        child: Checkbox(
                                          checkColor: Colors.red,
                                          value: provider.checkval,
                                          onChanged: (val){
                                            provider.updateCheck(val!);
                                          },
                                        ),
                                      ),
                                      Container(

                                        child: Container(
                                          padding: EdgeInsets.only(left: 10,bottom: 5, top: 5),
                                          child: Text("By Continuing you agree to our Privacy \nPolicy,TOS",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Container(
                                  height: 45,
                                  width: sc_width,
                                  margin: EdgeInsets.only(left: 15, right: 15,top: 25, bottom: 10),
                                  child: ElevatedButton(


                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Colors.black87,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: (){

                                      provider.postData(context);
                                    },
                                    child: Text("Create Proflie",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10,bottom: 2, top: 2),
                                      child: Text("Referal Code",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Expanded(
                                    child: Container(

                                        padding: EdgeInsets.only(left: 10,bottom: 2, top: 2),
                                        child: TextField(
                                          controller: provider.txtreferalcode,
                                          decoration: new InputDecoration(
                                            labelText: "Enter Referal Code",
                                            prefixIcon: Icon(Icons.numbers_outlined),
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(10.0),
                                              borderSide: new BorderSide(
                                              ),
                                            ),
                                            //fillColor: Colors.green
                                          ),
                                        )
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),



                          Align(
                            alignment: Alignment.centerLeft,
                            child:  Expanded(
                              child: Container(
                                width: sc_width,
                                padding: EdgeInsets.only(left: 10,bottom: 2, top: 5),
                                child: Text("${provider.txtresponse.toString()}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      );
                    },
                  ),

                ],
              ) ,
              ),
            ),
          );
        }));
  }
}