import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flight_booking_flutter_app/widgets/deal_carousel.dart';
import 'package:flight_booking_flutter_app/widgets/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flight_booking_flutter_app/pages/nestedTabBarView.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  @override

  _HomeScreenState createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  Color color = Colors.indigo;
  final List<Widget> _children = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildClipPath(context),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildButtonColumn(color, FontAwesomeIcons.plane, 'Flight','/flight'),),
                Expanded(child: _buildButtonColumn(color, FontAwesomeIcons.bed, 'Hotels','/hotels'),),
                Expanded(child: _buildButtonColumn(color, FontAwesomeIcons.bus, 'Bus','/bus'),),
                Expanded(child: _buildButtonColumn(color, FontAwesomeIcons.vihara, 'Holidays','/bus'),)
              ],
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Destination',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            NestedTabBar(),
            // SizedBox(height: 20.0),
            DealCarousel(),
            // SizedBox(height: 20.0),
           // DestinationCarousel(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          switch (_currentTab) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              check_is_login();
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.workspaces_filled,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage('https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png'),
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  // Widget buttonSection = Container(
  //
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //         _buildButtonColumn(Colors.red, Icons.share, 'CALL'),
  //         _buildButtonColumn(Colors.red, Icons.near_me, 'ROUTE'),
  //         _buildButtonColumn(Colors.red, Icons.share, 'SHARE'),
  //     ],
  //   ),
  // );

  Widget _buildButtonColumn(Color color, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, route);
      },
      child: Container(

        decoration: BoxDecoration(

            border: Border(
                right: BorderSide( //                   <--- left side
                  color: HexColor("DADADA"),
                  width: 1.0,
                ),
                bottom: BorderSide( //                    <--- top side
                  color: HexColor("DADADA"),
                  width: 1.0,

                ),),   // set border width
         // make rounded corner of border
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 20.5),
        child:Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: color,size:20),

          Container(
            margin: const EdgeInsets.only(top: 8),

            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: HexColor("000000"),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  void check_is_login() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id');
    if(user_id==null)
      {
        Navigator.pushNamed(context, '/user_login');
      }else{
      Navigator.pushReplacementNamed(
          context, '/user_profile', arguments: {
        'user_id':user_id,
        });
    }

  }


  @override
  Widget _buildClipPath(BuildContext context) {
    return ClipPath(
        child: Container(
        padding: EdgeInsets.only(left: 100.0, right: 120.0),
        width: MediaQuery.of(context).size.width,
        height: 90,
        color: HexColor('#175BA2'),
        child: Column(
          children: <Widget>[
            SizedBox(height: 3,),
            ClipRRect(
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              ),
              child: Image.network(
              'https://demo.softgneer.com/bookingapp/images/app/demmast1.jpeg',
              width: 90,
              height: 70,
              fit:BoxFit.fill

              ),
              ),
          ],
          ),

            ),
        clipper:CustomClipPath()
        );
      }
}


class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800];
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 30.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

