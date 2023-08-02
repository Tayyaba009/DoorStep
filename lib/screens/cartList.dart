import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/providers/providers.dart';
import '/main.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkout.dart';

class Cartlist extends StatefulWidget{
  _CartList createState() => _CartList();
}
class _CartList extends State<Cartlist> {


  double totalCartPrice = 0;

  double getTotal() {
    double v = 0;
    int i = 0;
    int length = MyApp.Mcartlast.length;
    for (i = 0; i < length; i++) {
      v = v + double.parse(MyApp.Mcartlast[i].tprice.toString());
    }
    return v;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      totalCartPrice = getTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<EligiblityScreenProvider>(
      create: (context) => EligiblityScreenProvider(),
      child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
                  home:Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.grey),
                      elevation: 0,
                      title: Text("My Cart",
                        style: GoogleFonts.barlow (
                          fontSize: 24,
                          color: (Colors.black87),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: (){
                            MyApp.Mcartlast.clear();
                            setState(() {

                            });
                          },
                           child: Container(
                             padding: EdgeInsets.only(right: 15),
                             child: Icon(Icons.remove_shopping_cart,
                               size: 32,
                               color: (Colors.grey[500])!,
                             ),
                           ),
                        ),
                      ],
                    ),
                 body:   Container(
                  decoration: BoxDecoration(
                      color: Colors.white10
                  ),

                  child:  Container(

                        child: MyApp.Mcartlast.length == 0 ? Center(

                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Cart is Empty",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ) :
                        ListView.builder(
                            itemCount: MyApp.Mcartlast.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(1),
                                elevation: 0,
                                child: ListTile(

                                  title: Text(
                                              MyApp.Mcartlast[index].ptitle.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                              ),
                                            ),

                                  subtitle: Container(
                                    margin: EdgeInsets.all(0),

                                    child: Row(
                                      children: <Widget>[
                                        Container( //    Cpntainer for Unit price
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text(
                                              MyApp.Mcartlast[index].uprice
                                                  .toString() + " RS",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black87
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 70,
                                          child: GestureDetector(
                                              onTap: () {
                                                int a = int.parse(
                                                    MyApp.Mcartlast[index].qnty
                                                        .toString());
                                                double b = double.parse(
                                                    MyApp.Mcartlast[index].uprice
                                                        .toString());
                                                if (a <= 0) {

                                                }
                                                else {
                                                  a--;
                                                }

                                                double d = b * a.toDouble();
                                                MyApp.Mcartlast[index].qnty =  (a).toString();
                                                totalCartPrice = getTotal();
                                                setState(() {
                                                  MyApp.Mcartlast[index].tprice = (d).toString();
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_circle_outline,
                                                size: 25,
                                              ),
                                          ),
                                        ),


                                        Container( //    Cpntainer for Unit price
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text(MyApp.Mcartlast[index].qnty.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black87
                                              ),
                                            ),
                                          ),
                                        ),


                                        Container(
                                            width: 70,
                                            child: GestureDetector(
                                              onTap: () {
                                                int a= int.parse(MyApp.Mcartlast[index].qnty.toString());
                                                double b= double.parse(MyApp.Mcartlast[index].uprice.toString()) ;
                                                a++;
                                                double d= b *  a.toDouble();
                                                MyApp.Mcartlast[index].qnty = a.toString();
                                                setState(() {
                                                  MyApp.Mcartlast[index].tprice= d.toString();
                                                  totalCartPrice= getTotal();
                                                });

                                              },
                                              child: Icon(
                                                Icons.add_circle_outline,
                                                size: 25,
                                              ),
                                            )
                                        ),


                                        Container( //    Cpntainer for Unit price
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text(MyApp.Mcartlast[index].tprice.toString() ,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black87
                                              ),
                                            ),
                                          ),
                                        ),


                                     Container(
                                              padding: EdgeInsets.only(left: 10),
                                              child: GestureDetector(
                                                onTap: (){
                                                  MyApp.Mcartlast.removeAt(index);
                                                  totalCartPrice= getTotal();
                                                  setState(() {


                                                  });
                                                },
                                                child: Icon(Icons.highlight_remove,
                                                  color: Colors.red,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                  leading: Image.network(
                                      MyApp.Mcartlast[index].image.toString()),
                                ),

                              );
                            }
                        ),
                      ),
                ),
                    bottomSheet: Row(
                      children: [
                        Container(
                          height: 70,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2),
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white
                                ),

                                child: Column(

                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 15,
                                                right: 5,
                                                top: 7,
                                                bottom: 1),
                                            child: Text("Items   :",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: EdgeInsets.only(left: 10,
                                                right: 5,
                                                top: 7,
                                                bottom: 1),
                                            child: Text(MyApp.Mcartlast.length.toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 15,
                                                right: 1,
                                                top: 4,
                                                bottom: 1),
                                            child: Text("Total  : ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: EdgeInsets.only(left: 1,
                                                right: 3,
                                                top: 4,
                                                bottom: 1),
                                            child: Text(
                                              "Rs. " + totalCartPrice.toString(),
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),

                              Positioned(
                                bottom: 5,
                                  right: 5,
                                  child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  CheckOut ()),);
                                },
                                   child: Container(
                                     padding: EdgeInsets.all(12),
                                       width: (MediaQuery
                                           .of(context)
                                           .size
                                           .width / 2.1) - 5,
                                       height: 50,
                                       decoration: BoxDecoration(
                                         gradient: LinearGradient(
                                           begin: Alignment.centerLeft,
                                           end: Alignment.centerRight,
                                           colors: [
                                             Color( 0xFFDF6E56),
                                              Color(0xFFFF4A25),
                                           ],
                                         ),
                                         borderRadius: BorderRadius.all(
                                             Radius.circular(10),
                                         ),
                                       ),
                                      child: Text("Check out",
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 20
                                       ),
                                      ),

                                   ),
                              ) )
                            ],
                          ),
                        ),
                      ],
                    ),
              ),
            );
          }
      ),
    );
  }
}