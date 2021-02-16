import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HotelSearchPage extends StatefulWidget {
  @override
  _HotelSearchPageState createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {
  String _findCity = "Dubai";
  String _findCityCode = "Dubai";
  String _fidnCityLongName =
      "Dubai, United Arab";

  bool is_travelforWork=false;

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
                    text: 'Hotels',
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
                  CityInfo(_findCityCode, _findCity,
                      _fidnCityLongName),
                  Icons.flight_takeoff,
                  "City/Hotel"),
            ),
            Container(height: 1, color: Colors.black26),


            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {},
                    child: buildDateSelector('Check In', DateTime.now()),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12, // set border color
                          width: 1.0), // set border width
                      // make rounded corner of border
                    ),
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      onPressed: () {},
                      child: buildDateSelector(
                          'Check Out', DateTime.now().add(Duration(days: 10))),
                    ),
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
            SizedBox(height: 12),
            Container(
              child: Center(
                child: Row(
                  children: [
                    Text(
                      "Traveling For:",
                      style: GoogleFonts.overpass(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                      value: is_travelforWork,
                      onChanged: (bool value) {
                        setState(() {
                          is_travelforWork = value;
                        });
                      },
                      activeColor: Color(0xFF6200EE),
                    ),
                    Text(
                      'Work',

                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),

              ),
            ),
            SizedBox(height: 10),
            Container(
              child: RaisedButton(
                child: Text(
                  "Search Hotels",
                  style: GoogleFonts.overpass(fontSize: 24),
                ),
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(80, 15, 90, 15),
                splashColor: Colors.grey,
              ),
            ),



            // Row(
            //   children: [
            //     SizedBox(height: 20.0),
            //     Padding(
            //       padding: EdgeInsets.only(left: 20.0, right: 120.0),
            //       child: Text(
            //         'Trending',
            //         style: TextStyle(
            //           fontSize: 12.0,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(left: 20.0, right: 120.0),
            //       child: Text(
            //         'Destination',
            //         style: TextStyle(
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // ),
            // NestedTabBar(),
          ],
        ),

      ),
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
  Widget buildTravellersView() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Room & Guest',
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'room 1 & guest 1',
              style: GoogleFonts.overpass(fontSize: 18,fontWeight: FontWeight.bold),
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
        Row(
          children: [
            Icon(Icons.calendar_today),
            Text(
              title,
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
          ],
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

}

