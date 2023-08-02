import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/screens/dashboard.dart';
import '/utils/apputils.dart';
import '/main.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';


class CreateProvider extends ChangeNotifier{



  String countrycode = "";

  void updtecode(String a){
    countrycode =a;
    notifyListeners();
  }

  TextEditingController txtname  = new TextEditingController(text: FirebaseAuth.instance.currentUser!.displayName.toString());
  TextEditingController txtphoneno = new TextEditingController();
  TextEditingController txtemail = new TextEditingController(text: FirebaseAuth.instance.currentUser!.email.toString());
  TextEditingController txtreferalcode = new TextEditingController();

  String txtresponse = "";


  updateMessge(String a){
    txtresponse = a;
    notifyListeners();
  }

  bool checkval = false;

  updateCheck(bool a){
    if(checkval== true){
      checkval= false;
    }else{
      checkval = true;
    }
    notifyListeners();
  }

  postData(BuildContext context) async{

    if(txtname.text == ""){
      updateMessge("Enter Full Name");
    } else if(txtemail.text == ""){
      updateMessge("Enter Email");
    } else if(txtphoneno.text == ""){
      updateMessge("Enter Phone Number");
    }
    else {
      try {
        showLoaderDialog(context);
        updateMessge("");
        //String ur = MyApp.baseUrl.toString()+ "api.php?postUsermobileRegister";
        String ur = "https://reward.hushburg.com/prizexx/api.php?postUsermobileRegister";
        var uri = Uri.parse(ur.toString());
        var request = new http.MultipartRequest("POST", uri);
        request.fields["name"] = txtname.text;
        request.fields["email"] = txtemail.text;
        request.fields["phone"] =countrycode+""+txtphoneno.text ;
        request.fields["password"] = FirebaseAuth.instance.currentUser!.uid.toString();
        request.fields["refferal_code"] = txtreferalcode.text;
        var response  =  await request.send();
        response.stream.transform(utf8.decoder).listen((event) {

        });

        if(response.statusCode == 200 ){
          AppUtils.saveName(txtname.text);
          AppUtils.saveEmail(txtemail.text);
          AppUtils.savePhoneNumber(txtphoneno.text);
          AppUtils.saveBalance("0");
          String a =await  AppUtils.readName() as String;
          updateMessge("Created Successfully Name is :"+a.toString());
          Navigator.of(context, rootNavigator: true).pop();

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return DashBoard();
          }));



        } else {
          Navigator.of(context, rootNavigator: true).pop();


          updateMessge("Uploadeing Failed"+response.statusCode.toString());
        }

      } catch (e) {
        updateMessge("Failed to create ");

        Navigator.of(context, rootNavigator: true).pop();
        print(e.toString());
        //updateMessge("Exception has been ocured"+e.toString());
      }
    }
  }



  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Profile creating ..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}