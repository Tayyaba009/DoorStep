import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '/DBoy/db_dashboard.dart';
import '/DBoy/dbsignup.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'dbauthprovider/dbloginprovider.dart';



class DBLogin extends StatefulWidget {
  @override
  _DBLogin createState() => _DBLogin();
}

class _DBLogin extends State<DBLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<DBLoginProvider>(

        create: (_) => DBLoginProvider(),
        child: Consumer<DBLoginProvider>(
        builder: (context,model,child)=> MaterialApp(
        home: Scaffold(

            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              height: sheight,
              width: swidth,
              padding: EdgeInsets.all(10.0),

              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  width: 400,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          Image.asset("images/logo1.jpeg",
                            width: 120,
                            height: 120,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Login",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                          SizedBox(height: 10.0),

                         Consumer<DBLoginProvider>(
                             builder: (context,provider,child){

                               return  Container(
                                 width: swidth,
                                 child: TextFormField(
                                   style: TextStyle(
                                       fontSize: 16,
                                       color: Colors.black54
                                   ),
                                   validator: (value) =>
                                       Validator.validateEmail(email: value.toString()),
                                   controller: provider.txtusername,
                                   keyboardType: TextInputType.emailAddress,
                                   decoration: InputDecoration(
                                     prefixIcon: Icon(Icons.email),
                                     hintText: "Email",
                                     labelText: "Email",
                                     //border: OutlineInputBorder(),
                                     border: InputBorder.none,
                                     filled: true,
                                   ),
                                 ),
                               );
                             }),



                          SizedBox(height: 5.0),


                         Container(
                           child: Consumer<DBLoginProvider>(
                             builder: (context,provider,child){
                               return  Container(
                                 width: swidth,
                                 child: TextFormField(
                                   style: TextStyle(
                                       fontSize: 16,
                                       color: Colors.black54
                                   ),
                                   controller: provider.txtpassword,
                                   validator: (value) =>
                                       Validator.validatePassword(password: value
                                           .toString()),
                                   keyboardType: TextInputType.text,
                                   obscureText: true,
                                   decoration: InputDecoration(
                                     prefixIcon: Icon(Icons.password),
                                     hintText: "Password",
                                     labelText: "Password",
                                     //border: OutlineInputBorder(),
                                     border: InputBorder.none,
                                     filled: true,
                                   ),
                                 ),
                               );
                             },
                           ),
                         ),


                          SizedBox(height: 20.0),


                          Container(
                            child: Consumer<DBLoginProvider>(
                              builder: (context,provider,child){
                                return   Container(
                                  width: swidth,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: ()async {

                                      if(provider.txtusername.text == ""){
                                         provider.updateMessge("Enter Email First");
                                      } else if(provider.txtpassword.text == ""){
                                        provider.updateMessge("Enter Password First");
                                      } else {
                                        provider.buildProgressDialog(context);
                                        User? user  = await  provider.signInUsingEmailPassword(
                                            email: provider.txtusername.text,
                                            password: provider.txtpassword.text,
                                            context: context);

                                        if (user != null) {
                                          Navigator.of(context, rootNavigator: true).pop();
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DBDashBoard()),);
                                        }
                                        else{
                                          Navigator.of(context, rootNavigator: true).pop();
                                        }
                                      }

                                    },
                                    child: const Text('SignIn',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff00A36C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),

                                );
                              },
                            )
                          ),

                          SizedBox(height: 10.0),

                          Container(
                            width: swidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  height: 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.black54
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("Or",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ),


                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  height: 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.black54
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),


                          Container(
                            padding: EdgeInsets.all(10),
                            child: Consumer<DBLoginProvider>(
                              builder: (context,provider,child){
                                return Container(
                                  child: Text("${provider.responseMessage.toString()}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red
                                    ),
                                  ),
                                );
                              },
                            )
                          ),

                          SizedBox(height: 10.0),

                          GestureDetector(

                            child: Container(
                              width: swidth,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  "If you do not have account ? Sign Up !",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DBSignUp()),
                              );
                            },
                          ),

                        ]),
                  ),
                ),
              ),
            )
        ),),),
    );
  }


  ///----------------------------------------------------------------------------------------

  Future<void> getNavigate() async {
    Navigator.of(context, rootNavigator: true).pop();
   // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
  }
}

class Validator {
  static String? validateName({required String name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

}
