import 'package:flutter/material.dart';
import 'package:raju_project1/admin/screens/DBoyManagement.dart';
import 'package:raju_project1/admin/screens/ProductsManagement.dart';
import 'package:raju_project1/admin/screens/analytics.dart';
import 'package:raju_project1/admin/screens/category.dart';
import '/screens/orderHistory.dart';
import '/screens/home.dart';
import '/res/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'VendorManagement.dart';
import 'orderManagement.dart';

class AdminDashBoard extends StatefulWidget {
  @override
  _AdminDashBoard createState() => _AdminDashBoard();
}

class _AdminDashBoard extends State<AdminDashBoard> {


  String username = "";

  @override
  void initState() {
    super.initState();
  }


  ScrollController scrollController = new ScrollController();
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    //Shopping(),
  ];


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PageController _controller = PageController( initialPage: 0,);
  int _curr = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.jumpToPage(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebasebtncolor,

      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title:  Row(
            children: [


              Container(
                child: Text("Doorstep Market",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 18,
                    fontWeight: FontWeight.bold

                  ),
                ),
              ),

              SizedBox( width: 110,),

            ],
          )
      ),

      drawer: Drawer(
        child: ListView(
          controller: scrollController,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(

                  child: Column(
                    children: [

                      Container (
                        padding: EdgeInsets.all(5),
                        child: Text( "",
                          style: GoogleFonts.inter(
                              fontSize: 16,fontWeight: FontWeight.w400
                          ),
                        ),
                      ),

                    ],
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Admin Dashboard'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardWidget()));
              },
            ),

            Container(
              height: 0.5,
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Add Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdminCategory()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),

            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Product Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdminNewProduct()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),

            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Manage Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OrderManagement()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text("Order History"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OrderHistory()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
           // ListTile(
      //  leading: Icon(
      //  Icons.person,
      //        ),
        //      title: const Text('Vendor Management'),
          //    onTap: () {
            //    Navigator.push(
              //    context,
                //  MaterialPageRoute(builder: (context) =>  VendorManagement()),
               // );
              //},
          //  ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),


            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Delievery Boy Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   DBoyManagement()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),

            ListTile(
              leading: Icon(
                Icons.contact_page,
              ),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Container(
              height: 0.5,
              color: Colors.black54,
            ),

            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () {
              //  FirebaseAuth.instance.signOut();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Login()),
              //   );
              },
            ),

            Container(
              height: 0.5,
              color: Colors.black54,
            ),

          ],
        ),
      ),


      body:Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bgimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}