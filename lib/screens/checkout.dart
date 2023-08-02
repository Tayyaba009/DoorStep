import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/orderDetailsDataModel.dart';
import '/screens/dashboard.dart';
import '/models/ordersModel.dart';
import '/main.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class CheckOut extends  StatefulWidget{
  _CheckOut createState() => new _CheckOut();
}
class _CheckOut extends State<CheckOut>{
  Position? position;
  TextEditingController _addressController =  new TextEditingController();
  String currentAddress = "Unnamed";
  String? postalcode = "Unnamed";

  double totalprice = 0 ;


  //----------------------------------------------------------------------------

  Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(32.5742, 73.4828),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.5742, 73.4828),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  //----------------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double swidth = size.width;
    final double sheight = size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: (Colors.grey[600])!),
          elevation: 0,
          title: Text("Check Out",
            style: GoogleFonts.barlow (
              color: (Colors.white),
            ),
          ),

          leading: GestureDetector(
            onTap: () { Navigator.pop(context); },
            child: Icon(
              Icons.arrow_back, color: Colors.white, // add custom icons also
            ),
          ),
        ),
         body: Container(
           color: Colors.white,
           child: ListView(
              shrinkWrap: true,
             children: [

               Container(
                 width: swidth,
                 color: Colors.grey[100],

                 child: Expanded(
                   child:  Container(
                     width:swidth - 130,
                     padding: EdgeInsets.only(left: 10,bottom: 10, top: 10),
                     child: Text("Account Info",
                       style: GoogleFonts.roboto(
                           fontSize: 22,
                           color: Colors.black54,
                           fontWeight: FontWeight.w400
                       ),
                     ),
                   ),
                 )
               ),

               Expanded(
                 child: Container(
                     padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                     width:swidth,
                    child:Row(

                       children: [
                         Container(
                           child: Icon(Icons.person,
                             color: (Colors.black54),
                             size: 28,
                           ),
                         ),

                         Container(

                           padding: EdgeInsets.only(left: 10,),
                           child: Text("${MyApp.getName()}",
                             style: GoogleFonts.roboto(
                                 fontSize: 20,
                                 color: Colors.black87,
                                 fontWeight: FontWeight.w400
                             ),
                           ),
                         ),
                       ],
                    )
                 ),
               ),


               //-----------------------------------------------------

               Expanded(
                 child: Container(
                   padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                   width:swidth,
                   child:Row(

                     children: [
                       Container(
                         child: Icon(Icons.email_sharp,
                           color: (Colors.black54),
                           size: 28,
                         ),
                       ),

                       Container(

                         padding: EdgeInsets.only(left: 10,),
                         child: Text("${FirebaseAuth.instance.currentUser!.email.toString()}",
                           style: GoogleFonts.roboto(
                               fontSize: 20,
                               color: Colors.black87,
                               fontWeight: FontWeight.w400
                           ),
                         ),
                       ),
                     ],
                   )
               ),
               ),

               //--------------------------------------------------------------------------------

               //-----------------------------------------------------

               Expanded(
                 child: Container(
                     padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                     width:swidth,
                     child:Row(

                       children: [
                         Container(
                           child: Icon(Icons.phone_android,
                             color: (Colors.black54),
                             size: 28,
                           ),
                         ),

                         Container(

                           padding: EdgeInsets.only(left: 10,),
                           child: Text("${MyApp.getPhone()}",
                             style: GoogleFonts.roboto(
                                 fontSize: 20,
                                 color: Colors.black87,
                                 fontWeight: FontWeight.w400
                             ),
                           ),
                         ),
                       ],
                     )
                 ),
               ),

               //--------------------------------------------------------------------------------


               Container(
                 width: swidth,
                 color: Colors.grey[100],

                 child:  Expanded(
                   child: Container(
                     width:swidth - 130,
                     padding: EdgeInsets.only(left: 10,bottom: 10, top: 10),
                     child: Text("Billing Info",
                       style: GoogleFonts.roboto(
                           fontSize: 22,
                           color: Colors.black54,
                           fontWeight: FontWeight.w400
                       ),
                     ),
                   ),
                 ),
               ),

               //-----------------------------------------------------

               Container(
                   padding: EdgeInsets.only(left: 10, top: 5, right: 10),

                   child:Row(

                     children: [

                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Expanded(
                          child: Container(
                            width:swidth - 200,
                            padding: EdgeInsets.only(left: 10,bottom: 10, top: 10),
                            child: Text("Total Items",
                              style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ),
                      ),

                       Align(
                         alignment: Alignment.centerRight,
                          child:  Expanded(
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.only(left: 10,bottom: 10, top: 10),
                             child: Text("${MyApp.Mcartlast.length.toString()}",
                             textAlign: TextAlign.right,
                             style: GoogleFonts.roboto(
                                 fontSize: 22,
                                 color: Colors.black87,
                                 fontWeight: FontWeight.bold
                              ),
                             ),
                         ),
                          ),
                       ),

                     ],
                   )
               ),


               //-----------------------------------------------------

               Container(
                   padding: EdgeInsets.only(left: 10, top: 10, right: 10),

                   child:Row(

                     children: [

                       Align(
                         alignment: Alignment.centerLeft,
                         child:  Expanded(
                           child: Container(
                             width:swidth - 200,
                             padding: EdgeInsets.only(left: 10,bottom: 5, top: 10),
                             child: Text("Bill Amount",
                               style: GoogleFonts.roboto(
                                   fontSize: 22,
                                   color: Colors.black87,
                                   fontWeight: FontWeight.w400
                               ),
                             ),
                           ),
                         )
                       ,),

                       Align(
                         alignment: Alignment.centerRight,
                         child:  Expanded(
                           child: Container(
                             width: 150,
                             padding: EdgeInsets.only(left: 10,bottom: 5, top: 5),
                             child: Text("RS. ${gettotal()}",
                               textAlign: TextAlign.right,
                               style: GoogleFonts.roboto(
                                   fontSize: 22,
                                   color: Colors.black87,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                         ),
                       ),

                     ],
                   )
               ),



               //-----------------------End Google Maps ---------------------------------------------------------

               Container(
                 margin: EdgeInsets.all(5),
                 height: 280,
                 child: SafeArea(
                   // on below line creating google maps
                   child: GoogleMap(
                     // on below line setting camera position
                     initialCameraPosition: _kGoogle,
                     // on below line we are setting markers on the map
                     markers: Set<Marker>.of(_markers),
                     // on below line specifying map type.
                     mapType: MapType.normal,
                     // on below line setting user location enabled.
                     myLocationEnabled: true,
                     // on below line setting compass enabled.
                     compassEnabled: true,
                     // on below line specifying controller on map complete.
                     onMapCreated: (GoogleMapController controller){
                       _controller.complete(controller);
                     },
                   ),
                 ),
               ),

               //-----------------------End Google Maps ---------------------------------------------------------

              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
                child:  ElevatedButton(

                  onPressed: () async{
                    getUserCurrentLocation().then((value) async {
                      print(value.latitude.toString() +" "+value.longitude.toString());

                      position =  Position(
                          longitude: value.longitude,
                          latitude: value.latitude,
                          timestamp: value.timestamp,
                          accuracy: value.accuracy,
                          altitude: value.altitude,
                          heading: value.heading,
                          speed: value.speed,
                          speedAccuracy: value.accuracy
                      );
                      // marker added for current users location
                      _markers.add(
                          Marker(
                            markerId: MarkerId("2"),
                            position: LatLng(value.latitude, value.longitude),
                            infoWindow: InfoWindow(
                              title: 'My Current Location',
                            ),
                          )
                      );

                      // specified current users location
                      CameraPosition cameraPosition = new CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 14,
                      );

                      final GoogleMapController controller = await _controller.future;
                      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                      setState(() {
                      });
                    });
                  },
                  child: Text('Get Current Location'),
                ),
              ),
               //-----------------------End Google Maps ---------------------------------------------------------

             ],
           ),

        ),
        bottomSheet: Row(
          children: [
            Positioned(
                bottom: 5,
                right: 5,
                child: ElevatedButton(
                  child: Text("Check Out"),
                  onPressed: (){
                    submitOrder();
                  }),
                )
          ],
        ),
      ),
    );
  }


  FirebaseFirestore _db = FirebaseFirestore.instance;
  submitOrder() async{

     if(MyApp.Mcartlast.isEmpty|| MyApp.Mcartlast.length == 0){
       Fluttertoast.showToast(
           msg: "There is no item im the Cart",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }

    else  if(position == null){

       Fluttertoast.showToast(
           msg: "Position is Null",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );

     } else {
       OrderDataModel model = new OrderDataModel(
           id: "",
           date: DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().year.toString(),
           userid: FirebaseAuth.instance.currentUser!.uid.toString(),
           name: "Waqas Umar",
           d_address: "",
           lati: position!.latitude.toString(),
           longi: position!.longitude.toString(),
           amount: gettotal().toString(),
           paytype: "Unpaid",
           dbid: "Not Set",
           dbname: "Not Set",
           status: "Submitted"
       );


       await _db.collection("orders").add(model.toMap()).then((value) async{

         String id = value.id.toString();



         for(int i =0 ; i< MyApp.Mcartlast.length;i++){
           OrderDetailsDataModel dataModel = new OrderDetailsDataModel(
               id: id,
               postid: value.id.toString(),
               pid: MyApp.Mcartlast[i].p_id,
               ptitle: MyApp.Mcartlast[i].ptitle,
               unitrate: MyApp.Mcartlast[i].uprice,
               qnty: MyApp.Mcartlast[i].qnty.toString()+"",
               totalamount: MyApp.Mcartlast[i].tprice
           );
           await _db.collection("orderdetails").add(dataModel.toMap());
         }
       });

       Fluttertoast.showToast(
           msg: "Order Has Been Submmited",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );

       MyApp.Mcartlast.clear();

       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => DashBoard()),
       );

     }
  }



  Future<String> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = placemark.street.toString() + ", " + placemark.postalCode.toString() + ", " + placemark.locality.toString() + ', ' + placemark.country.toString();
        return address;
      }
    } catch (e) {
      print('Error: $e');
    }

    return 'Address not found';
  }

  double gettotal(){
    double total =0;
    for(int i=0 ; i< MyApp.Mcartlast.length ;i++){
      total = total + double.parse(MyApp.Mcartlast[i].tprice.toString()) ;
    }
    return total;
  }

}