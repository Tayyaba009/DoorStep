import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/screens/cartList.dart';
import '/screens/orderHistory.dart';
import '/screens/productslist.dart';
import '/screens/splashscreen.dart';
import '/utils/apputils.dart';
import '/profile/profileManagement.dart';
import '/screens/home.dart';
import '/res/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '/main.dart';
import 'EditProfile.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {


  String username = "";

  @override
  void initState() {
    super.initState();
    getname();
  }

  void getname() async {
    username = await AppUtils.getName();
    setState(() {});
  }

  ScrollController scrollController = new ScrollController();
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProductsListPage(),
    Cartlist(),
    EditAccount()
  ];


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PageController _controller = PageController(initialPage: 0,);
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

          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black87,
          title: Row(
            children: [
              Container(
                child: Text("Doorstep Market",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

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

                      // Container(
                      //   height: 75,
                      //   width: 75,
                      //   child:   ClipOval(
                      //
                      //     child: CachedNetworkImage(
                      //       fit: BoxFit.fill,
                      //       imageUrl: "https://media.gettyimages.com/id/2847785/photo/apple-ceo-steve-jobs-holds-a-new-mini-ipod-at-macworld-january-6-2004-in-san-francisco-jobs.jpg?s=612x612&w=0&k=20&c=_LbFcanFpdGCZx7rSHLi75AZWAkRHktMaJLmws7rLgQ=",
                      //       placeholder: (context, url) => CircularProgressIndicator(),
                      //       errorWidget: (context, url, error) => Icon(Icons.error),
                      //     ),
                      //   ),
                      // ),

                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text("",
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w400
                          ),
                        ),
                      ),


                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.lightGreenAccent, // Set icon color here
              ),
              title: const Text('Dashboard'),
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
                color: Colors.lightGreenAccent, // Set icon color here
                Icons.person,
              ),
              title: const Text('Order History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
              },
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),


            ListTile(
              leading: Icon(
                color: Colors.lightGreenAccent, // Set icon color here

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
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
            ),

            Container(
              height: 0.5,
            ),

          ],
        ),
      ),


      body: Container(
        child: PageView(
          allowImplicitScrolling: false,
          children: _widgetOptions,
          scrollDirection: Axis.horizontal,
          controller: _controller,
          onPageChanged: (num) {
            setState(() {
              _selectedIndex = num;
            });
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white, // Set the shadow color to transparent
              spreadRadius: 10.0,
              blurRadius: 5.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.lightGreenAccent),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, color: Colors.lightGreenAccent),
                label: "Products",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.lightGreenAccent),
                label: "My Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.lightGreenAccent),
                label: "Settings",
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightGreenAccent,
            unselectedItemColor: Colors.white,
            iconSize: 28,
            onTap: _onItemTapped,
            elevation: 0.0, // Set elevation to 0 to remove the default shadow
          ),
        ),
      ),


    );
  }
}