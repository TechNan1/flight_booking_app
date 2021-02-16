import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class FlightSearchPage extends StatefulWidget {
  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();

}

enum TripType { oneway, roundtrip, multicity }
enum ClassType {zero,one, two, three,four,five,six,seven,eight,nine }
final listcount=[0,1,2,3,4];
final listcountMap= listcount.asMap();

Map<TripType, String> _tripTypes = {
  TripType.oneway: 'ONE WAY',
  TripType.roundtrip: 'ROUNDTRIP',
  TripType.multicity: 'MULTICITY'
};
Map<TripType, int> _triptype = {
  TripType.oneway: 1,
  TripType.roundtrip: 2,
  TripType.multicity: 3
};

class _FlightSearchPageState extends State<FlightSearchPage> {
  Map data={};
  int _no_of_traveler=1;
  String _travel_class="Economy";
  TripType _selectedTrip = TripType.oneway;
  int _selectedtriptype=1;
  int _selectAdultCount=1;
  int _selectChildCount=0;
  int _selectInfantCount=0;
  int _totalTravelerCount=1;
  String _airportFromCode = "BOM";
  String _airportFromShortName = "Mumbai";
  String _airportFromLongName =
      "Chatrapati Shijavi Maharaj International Airport";
  String _airportToCode = "DEL";
  String _airportToShortName = "New Delhi";
  String _airportToLongName = "Indira Gandhi International Airport";
  int _totalTraveler=1;
  int _totalAdult=1;
  int _totalChild=0;
  int _totalInfant=0;

  String _travelClass="Economy";
  bool is_directFlightcheck=false;
  DateTime _departDate=DateTime.now();
  DateTime _returnDate=DateTime.now().add(Duration(days: 10));

  @override
  Widget build(BuildContext context) {
    const curveHeight = 10.0;

    final popup = BeautifulPopup(
      context: context,
      template: TemplateAuthentication,
    );
    data=ModalRoute.of(context).settings.arguments;
    if(data != null)
    {
      _travelClass=data['travel_class'];
      _totalTraveler=data['total_person'];
      _totalAdult=data['total_adult'];
      _totalChild=data['total_child'];
      _totalInfant=data['total_infant'];

      _airportFromCode = data['airportFromCode'];
      _airportFromShortName = data['airportFromShortName'];
      _airportFromLongName = data['airportFromLongName'];
      _airportToCode = data['airportToCode'];
      _airportToShortName = data['airportToShortName'];
      _airportToLongName = data['airportToLongName'];
      _departDate== null? data['departDate']:_departDate;
      _returnDate==null?data['returnDate']:_returnDate;

    }

    return Scaffold(
      appBar:  Customappbar( height: 70,titleText: "Flight Search",),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_tripTypes.length, (index) {
                      return buildTripTypeSelector(
                          _tripTypes.keys.elementAt(index));
                    }),
                  ),
                )
              ],
            ),
            Container(height: 1, color: Colors.black26),
            Container(height: 10),
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(4),
              onPressed: () {
                Navigator.pushNamed(context, '/choose_airport_from',arguments: {
                  'area':"from_main",
                  'fromiata':_airportFromCode,
                  'fromcity':_airportFromShortName,
                  'fromname':_airportFromLongName,
                  'toiata':_airportToCode,
                  'tocity':_airportToShortName,
                  'toname':_airportToLongName,
                  'total_person':_totalTraveler,
                  'travel_class':_travelClass,
                  'departDate':_departDate,
                  //'returnDate':_returnDate
                });
              },
              child: buildAirportSelector(
                  AirportInfo(_airportFromCode, _airportFromShortName,
                      _airportFromLongName),
                  Icons.flight_takeoff,
                  "From"),
            ),
            Container(height: 1, color: Colors.black26),
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(4),
              onPressed: () {
                Navigator.pushNamed(context, '/choose_airport_from',arguments: {
                  'area':"to_main",
                  'fromiata':_airportFromCode,
                  'fromcity':_airportFromShortName,
                  'fromname':_airportFromLongName,
                  'toiata':_airportToCode,
                  'tocity':_airportToShortName,
                  'toname':_airportToLongName,
                  'total_person':_totalTraveler,
                  'travel_class':_travelClass,
                  'departDate':_departDate,
                });
              },
              child: buildAirportSelector(
                  AirportInfo(
                      _airportToCode, _airportToShortName, _airportToLongName),
                  Icons.flight_land,
                  "To"),
            ),
            Container(height: 1, color: Colors.black26),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    onPressed: () {
                      return showDatePicker(context:context,
                          initialDate:_departDate== null? DateTime.now():_departDate, firstDate: DateTime(2020), lastDate: DateTime(2022)).then((date){
                        setState(() {
                          _departDate=date;
                          print(_departDate.month);
                          print(_departDate.runtimeType);
                        });
                      });
                    },
                    child: buildDateSelector('DEPART', _departDate),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12, // set border color
                          width: 0.0), // set border width
                    ),
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                      child: buildReturnDateSelector(
                          'RETURN', _returnDate),
                      onPressed: () {
                        if(_selectedTrip==TripType.roundtrip) {
                          return showDatePicker(context: context,
                              initialDate: _returnDate == null
                                  ? DateTime.now()
                                  : _returnDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2022)).then((date) {
                            setState(() {
                              _returnDate = date;
                            });
                          });
                        }
                      },
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/select_traveler',arguments: {
                        'fromiata':_airportFromCode,
                        'fromcity':_airportFromShortName,
                        'fromname':_airportFromLongName,
                        'toiata':_airportToCode,
                        'tocity':_airportToShortName,
                        'toname':_airportToLongName,
                        'total_person':_totalTraveler,
                        'total_adult':_totalAdult,
                        'total_child':_totalChild,
                        'travel_class':_travelClass,
                        'departDate':_departDate,
                        'returnDate':_returnDate,
                        'traveler':3,
                      });
                      // AwesomeDialog(
                      //   context: context,
                      //   headerAnimationLoop: false,
                      //   dialogType: DialogType.NO_HEADER,
                      //   body: Column(
                      //       children:<Widget>[
                      //         Row(
                      //           children: [
                      //             Text("Select Travel And Class")
                      //           ],
                      //         ),
                      //         Container(height: 1, color: Colors.black26),
                      //         Row(
                      //           // mainAxisSize: MainAxisSize.,
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children:[
                      //               buildTravelerSelector("Adult",_selectAdultCount),
                      //               buildTravelerSelectorOperation("Adult",_selectAdultCount),
                      //             ]
                      //         ),
                      //         Container(height: 1, color: Colors.black26),
                      //         Row(
                      //           // mainAxisSize:,
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children:[
                      //               buildTravelerSelector("Child",_selectChildCount),
                      //               buildTravelerSelectorOperation("Child",_selectChildCount),
                      //             ]
                      //         ),
                      //         Container(height: 1, color: Colors.black26),
                      //         Row(
                      //           // mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children:[
                      //               buildTravelerSelector("Infant",_selectInfantCount),
                      //               buildTravelerSelectorOperation("Infant",_selectInfantCount),
                      //             ]
                      //         ),
                      //
                      //
                      //       ]
                      //   ),
                      //   btnOkOnPress: () {
                      //     debugPrint('OnClcik');
                      //   },
                      //   btnOkIcon: Icons.check_circle,
                      // )..show();
                    },
                    child: buildTravellersView(_totalTraveler,_travelClass),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 18),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fares From',
                              style: GoogleFonts.overpass(
                                  fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              _airportFromShortName,
                              style: GoogleFonts.overpass(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
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
                    Checkbox(
                      value: is_directFlightcheck,
                      onChanged: (bool value) {
                        setState(() {
                          is_directFlightcheck = value;
                        });
                      },
                      activeColor: Color(0xFF6200EE),
                    ),
                    Text(
                      'Direct Flight',

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
                  "Search Flights",
                  style: GoogleFonts.overpass(fontSize: 24),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/flight_results',arguments: {
                    'fromiata':_airportFromCode,
                    'fromname':_airportFromLongName,
                    'fromcity':_airportFromShortName,
                    'toiata':_airportToCode,
                    'toname':_airportToLongName,
                    'tocity':_airportToShortName,
                    'trip':_selectedtriptype,
                    'depart_date':_departDate,
                    'return_date':_returnDate,
                    'total_person':_totalTraveler,
                    'total_adult':_totalAdult,
                    'total_child':_totalChild,
                    'total_infant':_totalInfant,
                    'travel_class':_travelClass,
                    'departDate':_departDate,
                    'returnDate':_returnDate
                  } );
                },
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


  Widget buildAirportSelector(
      AirportInfo airportInfo, IconData icon, String Lebel) {
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
                    airportInfo.airportShortName,
                    style: GoogleFonts.overpass(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    airportInfo.airportLongName,
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

  Widget buildTravellersView(int traveler, String travelcalss) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Travellers & Class',
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
            Row(
              children: [
                Text(
                  traveler.toString(),
                  style: GoogleFonts.overpass(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Travellers',
                  style: GoogleFonts.overpass(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  travelcalss,
                  style: GoogleFonts.overpass(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ],
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
                  returnDateMonthName(dateTime.month)+' '+dateTime.year.toString(),
                  style: GoogleFonts.overpass(fontSize: 16),
                ),
                Text(
                  returnWeekDayName(dateTime.weekday),
                  style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildReturnDateSelector(String title, DateTime dateTime) {

    if(_selectedTrip==TripType.roundtrip) {
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
                    returnDateMonthName(dateTime.month) + ' ' +
                        dateTime.year.toString(),
                    style: GoogleFonts.overpass(fontSize: 16),
                  ),
                  Text(
                    returnWeekDayName(dateTime.weekday),
                    style: GoogleFonts.overpass(
                        fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }else{
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
              children:[
                Text(
                  "Please select",
                  style: GoogleFonts.overpass(fontSize: 18),
                ),
              ]
          ),
          Row(
            children: [
              Text(
                "round trip",
                style: GoogleFonts.overpass(fontSize: 18),
              ),
            ],
          )

        ],
      );
    }
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;

    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
          _selectedtriptype=_triptype[tripType];

        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
            color: Color(0xFFE8E8E8), width: 1, style: BorderStyle.solid),
      ),
      color: isSelected ? Color(0XFF23417D) : Color(0xFFFFFFFF),
      child: Row(
        children: <Widget>[
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.white,
            )
          else
            Icon(
              FontAwesomeIcons.circle,
              color: Colors.blueGrey,
              size: 15,
            ),
          Text(
            _tripTypes[tripType],
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget TravlerNumberSelector(String type,int numvalue) {
    var isSelected = _selectAdultCount == numvalue;
    return FlatButton(
      // padding: EdgeInsets.only(left: 4, right: 6),
      onPressed: () {
        setState(() {
          _selectAdultCount=numvalue;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
            color: Color(0xFFE8E8E8), width: 1, style: BorderStyle.solid),
      ),
      color: isSelected ? Color(0XFF23417D) : Color(0xFFFFFFFF),
      child: Row(
        children: <Widget>[
          Text(
            "$numvalue",
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildTravelerSelector(String title,int count) {
    // var count;
    // if(title=="Adult")
    // {
    //   count=_selectAdultCount;
    // }if(title=="Child")
    // {
    //   count=_selectChildCount;
    // }if(title=="Infant")
    // {
    //   count=_selectInfantCount;
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.perm_identity_outlined),
            Text(
              title,
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              count.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 22),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget buildTravelerSelectorOperation(String title ,int count) {
    var current_count=count;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text('$current_count'),
            new FlatButton(
              onPressed:(){
                if(title=="Adult")
                {
                  count++;
                  current_count++;
                  setState(() {
                    _selectAdultCount++;

                  });
                }
              },


              child: new Icon(
                  Icons.add,
                  color: Colors.black),
            ),
            new FlatButton(
              onPressed: minusTraveler,
              child: new Icon(
                  Icons.remove,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  void getfrom(String code, String name, String longname) {
    _airportFromCode = code;
    _airportFromShortName = name;
    _airportFromLongName = longname;
  }

  void minusTraveler() {
    var actionFor="Adult";
    setState(() {
      if(actionFor =="Adult"){
        if (_selectAdultCount != 1)
          _selectAdultCount--;
      }
      if(actionFor =="Child"){
        _selectChildCount--;
      }
      if(actionFor =="Infant"){
        _selectInfantCount--;
      }
    });

  }
  void addTraveler() {
    var actionFor="Adult";
    setState(() {
      if(actionFor =="Adult"){
        if (_selectAdultCount <= 9)
          _selectAdultCount++;
      }
      if(actionFor =="Child"){
        if (_selectChildCount <= 9)
          _selectChildCount++;
      }
      if(actionFor =="Infant"){
        if (_selectInfantCount <= 9)
          _selectInfantCount++;
      }

    });
  }
}
