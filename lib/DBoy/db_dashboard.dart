import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/DBoy/dbhome.dart';
import '/screens/orderHistory.dart';
import '/screens/splashscreen.dart';
import '/utils/apputils.dart';
import '/res/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';



class DBDashBoard extends StatefulWidget {
  @override
  _DBDashBoard createState() => _DBDashBoard();
}

class _DBDashBoard extends State<DBDashBoard> {


  String username = "";

  @override
  void initState() {
    super.initState();
    getname();
  }

  void getname() async{
    username = await AppUtils.getName();
    setState(() {
    });
  }

  ScrollController scrollController = new ScrollController();
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DBHomePage(),
    Container( child: Text("Old History"),),
    Container( child: Text("Settings"),)
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
          iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.black87,
        title:  Row(
           children: [
             Container(
               child: Text("Delievry Boy",
                 style: GoogleFonts.inter(
                   color: Colors.white,
                   fontSize: 18
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

                      Container (
                        padding: EdgeInsets.all(5),
                        child: Text( "",
                          style: GoogleFonts.inter(
                              fontSize: 16,fontWeight: FontWeight.w400
                          ),
                        ),
                      ),


                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(FirebaseAuth.instance.currentUser!.email.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 14,fontWeight: FontWeight.w400
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
              ),
              title: const Text('Delievery Boy'),
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
                Icons.person,
              ),
              title: const Text('Order History'),
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
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
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

        child: PageView(
          allowImplicitScrolling:false,
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




      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,

          iconSize: 28,
          onTap: _onItemTapped,
          elevation: 0.1
      ),
    );
  }
}