import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flight_booking_flutter_app/models/airports_model.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';
import 'package:flight_booking_flutter_app/pages/flight_search_page.dart';

class AirportSearchPage extends StatefulWidget {
  AirportSearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AirportSearchPageState createState() => new _AirportSearchPageState();
}

class _AirportSearchPageState extends State<AirportSearchPage> {
  TextEditingController editingController = TextEditingController();

  final airportsItems = airports;
  var items = List<Airport>();

  @override
  void initState() {
    items.addAll(airportsItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Airport> dummySearchList = List<Airport>();
    dummySearchList.addAll(airportsItems);
    if(query.isNotEmpty) {
      List<Airport> dummyListData = List<Airport>();
      dummySearchList.forEach((item) {
        if(item.code.contains(query) || item.shortName.contains(query) || item.longName.contains(query))  {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(airportsItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text(widget.title),
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: Colors.indigo,
        shape: CustomShapeBorder(),

        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 32),
              children: [
                TextSpan(
                    text: 'Choose From',
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w900)),

              ]),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                 shrinkWrap: true,
                itemCount: items.length,

                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(height: 1, color: Colors.black26),
                      FlatButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        onPressed: () {

                          

                        },
                        child: buildAirportSelector(
                            AirportInfo('${items[index].code}', '${items[index].shortName}',
                                '${items[index].longName}'),
                            Icons.flight_takeoff ,""),
                      ),
                      Container(height: 9, color: Colors.black26),
                    ],
                    // title: Text('${items[index].code}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAirportSelector(AirportInfo airportInfo, IconData icon,String Lebel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 250,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Lebel,
                    style:
                    GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                  ),
                  Text(
                    airportInfo.airportShortName,
                    style:
                    GoogleFonts.overpass(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    airportInfo.airportLongName,
                    style:
                    GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),

            ),

          ],
        ),
        Column(
          children: [
            Container(
              width: 90,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    airportInfo.airportCode,
                    style: GoogleFonts.overpass(
                        fontWeight: FontWeight.w900,

                        fontSize: 24,
                        color: Colors.black54),
                  ),
                  Icon(icon),
                ],
              ),


            ),
          ],
        ),


      ],
    );
  }
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
