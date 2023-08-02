// import 'package:flutter/cupertino.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:raju_project1/models/shop_models/categoryDataModel.dart';
// import '/screens/productdetails.dart';
// import '/main.dart';
// import '/models/shop_models/productsDataModel.dart';
//
// class Shopping  extends StatefulWidget{
//
//   _Shopping createState() => new _Shopping();
// }
//
// class _Shopping extends State<Shopping>{
//
//   ScrollController controller = new ScrollController();
//
//
//   List<ProductDataModel> prolist = [];
//   List<CategoryDataModel> catlist = [];
//
//   getcategories() async{
//     catlist = await  getfromurlcat();
//     setState(() {});
//   }
//
//   getproducts() async{
//     prolist = await  getfromurl();
//     setState(() {});
//   }
//
//
//
//   Future<List<CategoryDataModel>> getfromurlcat() async {
//     var url = Uri.parse(MyApp.baseUrl.toString()+"getcatagories.php");
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => CategoryDataModel.fromJson(data)).toList();
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }
//
//
//
//   Future<List<ProductDataModel>> getfromurl() async {
//     var url = Uri.parse(MyApp.baseUrl.toString()+"getproducts.php");
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => ProductDataModel.fromJson(data)).toList();
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getcategories();
//     getproducts();
//
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return  Container(
//       color: Colors.white,
//       child: ListView(
//         controller: controller,
//         shrinkWrap: true,
//         children: [
//
//
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Text("Categories",
//               style: GoogleFonts.inter(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.black45
//               ),
//             ),
//           ),
//
//
//
//
//           Container(
//               margin: EdgeInsets.all(10),
//               child: catlist!.length == 0 ? Container(
//
//                 child: Center(
//                   child: Column(
//                     children: [
//
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text("Loading please ... ",
//                           style: GoogleFonts.inter(
//                               fontSize: 18,
//                               color: Colors.black45
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                           padding: EdgeInsets.all(20),
//                           child: CircularProgressIndicator()
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ) :
//
//               Container(
//                 child: GridView.builder(
//                     controller: controller,
//                     shrinkWrap: true  ,
//                     itemCount: catlist!.length,
//                     gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 200,
//                         childAspectRatio: 3 / 4,
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 20),
//                     itemBuilder: (context,index){
//
//                       return  GestureDetector(
//                         onTap: (){
//
//                         },
//                         child:   GridTile(
//
//                           key: ValueKey(catlist![index].id),
//                           footer: GridTileBar(
//                             backgroundColor: Colors.black54,
//                             title: Text(
//                               catlist![index].id,
//                               style:  GoogleFonts.inter(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Text("${catlist![index].title}"),
//                             //  trailing: const Icon(Icons.shopping_cart),
//                           ),
//                           child: Image.network(catlist![index].imagepath,
//                             fit: BoxFit.cover,
//                           ),
//
//                         ),
//                       );
//                     }),
//               )
//           ),
//
//
//
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Text("Products",
//               style: GoogleFonts.inter(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: Colors.black45
//               ),
//             ),
//           ),
//
//
//           Container(
//               margin: EdgeInsets.all(10),
//               child: prolist!.length == 0 ? Container(
//
//                 child: Center(
//                   child: Column(
//                     children: [
//
//                       Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text("Loading please ... ",
//                           style: GoogleFonts.inter(
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.black45
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                           padding: EdgeInsets.all(20),
//                           child: CircularProgressIndicator()
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ) :
//
//               Container(
//                 child: GridView.builder(
//                     controller: controller,
//                     shrinkWrap: true  ,
//                     itemCount: prolist!.length,
//                     gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 200,
//                         childAspectRatio: 3 / 4,
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 20),
//                         itemBuilder: (context,index){
//
//                       return  GestureDetector(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(prolist[index]) ),);
//
//                         },
//                         child:   GridTile(
//                           key: ValueKey(prolist![index].id),
//                           footer: GridTileBar(
//                             backgroundColor: Colors.black54,
//                             title: Text(
//                               prolist![index].id,
//                               style:  GoogleFonts.inter(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Text("${prolist![index].product_name}"),
//                             trailing: const Icon(Icons.shopping_cart),
//                           ),
//                           child: Image.network(MyApp.imageUrl+""+ prolist![index].product_image,
//                             fit: BoxFit.cover,
//                           ),
//
//                         ),
//                       );
//
//                     }),
//               )
//              ),
//            ],
//          ),
//
//     );
//   }
// }