import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BusSearchPage extends StatefulWidget {
  @override
  _BusSearchPageState createState() => _BusSearchPageState();
}

class _BusSearchPageState extends State<BusSearchPage> {


  @override
  Widget build(BuildContext context) {
    const curveHeight = 10.0;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        shape: const MyShapeBorder(curveHeight),
        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 24),
              children: [
                TextSpan(
                    text: 'Search ',

                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),
                TextSpan(
                    text: 'Bus',
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),

              ]),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(height: 30),
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(4),
              onPressed: () {
                Navigator.pushNamed(context, '/choose_airport_from');
              },
              child: buildFindCitySelector(
                  CityInfo("jaypur", "Jaypur",
                      "Jaypur, pink city"),
                  Icons.flight_takeoff,
                  "From"),
            ),
            Container(height: 1, color: Colors.black26),
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(4),
              onPressed: () {
                Navigator.pushNamed(context, '/choose_airport_from');
              },
              child: buildFindCitySelector(
                  CityInfo("delhi", "Delhi",
                      "Delhi, Capital city"),
                  Icons.flight_takeoff,
                  "To"),
            ),
            Container(height: 1, color: Colors.black26),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {},
                    child: buildDateSelector('Travel Date', DateTime.now()),
                  ),
                ),

              ],
            ),
            Container(height: 1, color: Colors.black26),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    onPressed: () {},
                    child: buildTravellersView(),
                  ),
                ),

              ],
            ),
            Container(height: 1, color: Colors.black26),
            SizedBox(height: 10),
            Container(
              child: RaisedButton(
                child: Text(
                  "Search Buses",
                  style: GoogleFonts.overpass(fontSize: 24),
                ),
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(80, 15, 90, 15),
                splashColor: Colors.grey,
              ),
            ),


          ],
        ),

      ),
    );
  }

  Widget buildTravellersView() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'TRAVELLERS',
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
            Text(
              '01',
              style: GoogleFonts.overpass(fontSize: 48),
            )
          ],
        ),
      ],
    );
  }

  Widget buildDateSelector(String title, DateTime dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Text(
              dateTime.day.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 48),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jan 2020',
                  style: GoogleFonts.overpass(fontSize: 16),
                ),
                Text(
                  'Friday',
                  style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFindCitySelector(
      CityInfo cityInfo, IconData icon, String Lebel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Lebel,
                    style: GoogleFonts.overpass(
                        fontSize: 12, color: Colors.black87),
                  ),
                  Text(
                    cityInfo.findCity,
                    style: GoogleFonts.overpass(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cityInfo.findCityLongName,
                    style: GoogleFonts.overpass(
                        fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ],
    );
  }




  @override
  Widget _buildClipPath(BuildContext context) {
    return ClipPath(
        child: Container(
          padding: EdgeInsets.only(left: 100.0, right: 120.0),
          width: MediaQuery.of(context).size.width,
          height: 90,
          color: Colors.redAccent,
          child: Column(
            children: <Widget>[
              Text(
                'Bus',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Search',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),

        ),
        clipper:CustomClipPath()
    );
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

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    final double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height - 30);
    path.quadraticBezierTo(
        rect.width / 2, rect.height,
        rect.width, rect.height - 30);
    path.lineTo(rect.width, 0);
    path.close();

    // path.lineTo(0, rect.height);
    // path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    // path.cubicTo(
    //     rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
    //     rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
    //     rect.width / 2 + 75, rect.height + 50
    // );
    // path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    // path.lineTo(rect.width, 0.0);
    // path.close();

    return path;
  }
}
