import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flight_booking_flutter_app/models/airports_model.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';

class ChooseFlightSource extends StatefulWidget {
  ChooseFlightSource({ Key key }) : super(key: key);
  @override
  _ChooseFlightSourceState createState() => new _ChooseFlightSourceState();
}

class _ChooseFlightSourceState extends State<ChooseFlightSource> {
  final formKey = new GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();

  final airportsItems = airports;
  var items = List<Airport>();

  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Map data={};
  DateTime _departDate=DateTime.now();
  DateTime _returnDate=DateTime.now().add(Duration(days: 10));

  Widget _appBarTitle = new Text( 'Select Airport' );


  _ChooseFlightSourceState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });

  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: SafeArea(
        child:Column(
          children: [
            if(filteredNames.isEmpty)
               LinearProgressIndicator(),

            _buildList(),
          ],
        )

      ),

    );
  }

  Widget _buildBar(BuildContext context) {
    data= ModalRoute.of(context).settings.arguments;
    _departDate=data['departDate'];
    _returnDate=data['returnDate'];

    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase()) || filteredNames[i]['iata'].toLowerCase().contains(_searchText.toLowerCase()) || filteredNames[i]['city'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      scrollDirection : Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new Row(
          children: [
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              onPressed: () {
                if(data['area']=="from_main") {
                  Navigator.pushReplacementNamed(
                      context, '/flight', arguments: {
                    'choose_airport':data['area'],
                    'airportFromCode': filteredNames[index]['iata'],
                    'airportFromLongName': filteredNames[index]['name'],
                    'airportFromShortName': filteredNames[index]['city'],
                    'airportToCode': data['toiata'],
                    'airportToLongName': data['toname'],
                    'airportToShortName': data['tocity'],
                    'total_person':data['total_person'],
                    'travel_class':data['travel_class'],
                    'departDate':_departDate,
                    'returnDate':_returnDate,


                  });
                }
                if(data['area']=="to_main") {
                  Navigator.pushReplacementNamed(
                      context, '/flight', arguments: {
                        'choose_airport':data['area'],
                    'airportToCode': filteredNames[index]['iata'],
                    'airportToLongName': filteredNames[index]['name'],
                    'airportToShortName': filteredNames[index]['city'],
                    'airportFromCode': data['fromiata'],
                    'airportFromLongName': data['fromname'],
                    'airportFromShortName': data['fromcity'],
                    'total_person':data['total_person'],
                    'travel_class':data['travel_class'],


                  });
                }

              },
              child: buildAirportSelector(
                  AirportInfo('${filteredNames[index]['iata']}', '${filteredNames[index]['city']}',
                      '${filteredNames[index]['name']}'),
                  Icons.flight_takeoff ,""),
            ),
          ],
          // title: Text(filteredNames[index]['name']),

          // onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Choose source airport' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    dio.options.headers['x-api-key'] = 'bookingapp';
    final response = await dio.post('https://demo.softgneer.com/bookingapp/api/airportList');
    List tempList = new List();
    for (int i = 0; i < response.data['airports'].length; i++) {
      tempList.add(response.data['airports'][i]);
    }
    setState(() {
      names = tempList;
      // names.shuffle();
      filteredNames = names;
    });
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
                  // Icon(icon),
                ],
              ),


            ),
          ],
        ),


      ],
    );
  }


}