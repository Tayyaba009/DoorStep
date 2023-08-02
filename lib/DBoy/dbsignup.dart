import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '/DBoy/dbauthprovider/dbsignupprovider.dart';
import '/auth/createAccount.dart';
import '/auth/login.dart';
import 'package:provider/provider.dart';


class DBSignUp extends StatefulWidget {

  @override
  _DBSignUp createState() => _DBSignUp();
}

class _DBSignUp extends State<DBSignUp> {
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
    return  ChangeNotifierProvider<DBSignUpProvider>(

        create: (_) => DBSignUpProvider(),
        child: Consumer<DBSignUpProvider>(
          builder: (context,model,child)=> MaterialApp(
          home: Scaffold(

            body: Container(
              color: Colors.white,
              height: sheight,
              width: swidth,
              padding: EdgeInsets.all(10.0),

              child: Center(
                child: Container(
                  width: 300,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[

                          SizedBox(height: 10.0),

                          Center(
                            child: Image.asset("images/logo1.jpeg",
                              width: 120,
                              height: 120,
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("SIGN UP",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),


                          SizedBox(height: 20.0),


                          Container(
                            child: Consumer<DBSignUpProvider>(
                              builder: (context,provider,child){
                                return  Container(
                                  width: swidth,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54
                                    ),
                                    controller: provider.txtusername,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        Validator.validateEmail(email: value
                                            .toString()),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "Enter Email",
                                      labelText: "Enter Email",
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


                          Consumer<DBSignUpProvider>(
                              builder: (context,provider,child){
                                return Container(
                                  width: swidth,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54
                                    ),
                                    controller: provider.txtpassword,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(password: value
                                            .toString()),
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

                          }),

                          SizedBox(height: 20.0),

                          Consumer<DBSignUpProvider>(
                              builder: (context,provider,child){
                                return  Container(
                                  width: swidth,
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54
                                    ),
                                    controller:provider.txtcpassword,
                                    validator: (value) =>
                                        Validator.validatePassword(password: value
                                            .toString()),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,

                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      hintText: "Re Enter Password",
                                      labelText: "Re Enter Password",
                                      //border: OutlineInputBorder(),
                                      border: InputBorder.none,
                                      filled: true,
                                    ),
                                  ),
                                );
                              }),

                          SizedBox(height: 20.0),



                          Container(
                            child: Consumer<DBSignUpProvider>(
                              builder: (context,provider,child){
                                return   Container(
                                  width: swidth,
                                  height: 50,
                                  child: ElevatedButton(


                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xff00A36C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),


                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Righteous',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // textColor: Colors.white,
                                      // color: Colors.orange,

                                      onPressed: () async {
                                        if (provider.txtusername.text == "") {
                                          provider.updateMessge("Please Enter User Name First");
                                        } else if (provider.txtpassword.text == "") {
                                          provider.updateMessge("Please Enter Password First");
                                        } else if (provider.txtcpassword.text == "") {
                                          provider.updateMessge("Please Re Enter Password First");
                                        }
                                        else
                                        if (provider.txtpassword.text != provider.txtcpassword.text) {
                                          provider.updateMessge("Password does not matched");
                                        }
                                        else {
                                         provider.buildProgressDialog(context);
                                          User? user = await provider.registerUsingEmailPassword(
                                              email:provider. txtusername.text,
                                              name: provider.txtname.text,
                                              password:provider. txtpassword.text);
                                          if (user != null) {
                                            Navigator.of(context, rootNavigator: true).pop();
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CreateAccount()),);
                                          }
                                          else{
                                            Navigator.of(context, rootNavigator: true).pop();
                                          }
                                        }
                                      }),
                                );
                              },
                            ),
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

                          SizedBox(height: 10.0),


                          Container(
                              padding: EdgeInsets.all(10),
                              child: Consumer<DBSignUpProvider>(
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


                          GestureDetector(

                            child: Container(
                              width: swidth,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  "If you have already account ? Login !",
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
                                    builder: (context) => Login()),
                              );
                            },
                          ),

                        ]),
                  ),
                ),
              ),
            )
          ),
        ),),
    );
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