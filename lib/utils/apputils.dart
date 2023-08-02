import 'package:shared_preferences/shared_preferences.dart';

class AppUtils{

  static saveName( String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
  }

  static saveEmail( String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }


  static savePhoneNumber( String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
  }

  static saveOneSignalId( String onesig) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("onesignalid", onesig);
  }

  static saveReferelCode( String refel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("referalcode", refel);
  }
  static saveProfileImagePath( String profilecode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profileImage", profilecode);
  }
  static saveBalance( String balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("balance", balance);
  }
  //-----------------------------------------------------------------------------------
  static Future<String?> readName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name");
  }
  static Future<String?> readEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }
  static Future<String?> readPhoneNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("phone");
  }



  static Future<String?> readOneSignalId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("onesignalid");
  }


  static Future<String?> readReferalID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("referalcode");
  }


  static Future<String?> readProfileImage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("profileImage");
  }

  static Future<String?> readBalance() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("saveBalance");
  }


  static Future<String>  getName() async {
    String a = await readName() as String;
    return a;
  }


  static Future<String>  getBalance() async {
    String a = await readBalance() as String;
    return a;
  }

}