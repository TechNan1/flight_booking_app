import 'dart:core';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/models/flight_model.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:google_fonts/google_fonts.dart';

class FlightBook extends StatelessWidget {
  final List<FlightResults> flight;
  final int index;
  FlightBook({Key key, this.flight, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.flight), text: "Flight Details"),
                Tab(icon: Icon(Icons.people), text: "Add Passengers"),
              ],
            ),
            title: Text('Flight Booking')),
        body: TabBarView(
          children: [
            _flightDetails(),
            MyCustomForm(),
          ],
        ),
      ),
    );
  }

  Widget _flightDetails() {
    return Column(
      children: [
        Text(flight[index].SrdvIndex),
        Text(flight[index].ResultIndex),
        //Text(flight[index].Source),
        Text(flight[index].AirlineRemark),
        Text(flight[index].Fare_Currency),
        Text(flight[index].Fare_PublishedFare),
        Text(flight[index].Fare_OfferedFare),
        Text(flight[index].Segments_Airline_airlinecode),
        Text(flight[index].Segments_Airline_airlinename),
        Text(flight[index].Segments_Airline_airlinenumber),
        Text(flight[index].Segments_Origin_airportcode),
        Text(flight[index].Segments_Origin_airportname),
        Text(flight[index].Segments_Origin_citycode),
        Text(flight[index].Segments_Origin_cityname),
        Text(flight[index].Segments_departfulldate),
        Text(flight[index].Segments_departtime),
        Text(flight[index].Segments_Destination_airportcode),
        Text(flight[index].Segments_Destination_airportname),
        Text(flight[index].Segments_Destination_citycode),
        Text(flight[index].Segments_Destination_cityname),
        Text(flight[index].Segments_arrivalfulldate),
        Text(flight[index].Segments_arrivaltime),
        Text(flight[index].Segments_Duration),
        Text(flight[index].Segments_GroundTime),
        Text(flight[index].Segments_StopOver),
      ],
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  int num = 0;
  static List<String> passengerList = [null];
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.email),
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              validator: (v) {
                return _validate(v);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
              validator: (v) {
                return _validate(v);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_on),
                hintText: 'Enter address',
                labelText: 'Address',
              ),
              validator: (v) {
                return _validate(v);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Add Passenger Details',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            )),
            ..._getPassengers(),
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Data is in processing.')));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  String _validate(String value) {
    if (value.isEmpty) return 'Please enter data';
    return null;
  }

  List<Widget> _getPassengers() {
    List<Widget> passengerFields = [];
    for (int i = 0; i < passengerList.length; i++) {
      passengerFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            _addRemoveButton(i == passengerList.length - 1, i),
            Expanded(child: PassengerFields(i)),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ));
    }
    return passengerFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          passengerList.insert(0, null);
        } else
          passengerList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

enum Gender { male, female }

class PassengerFields extends StatefulWidget {
  final int index;
  PassengerFields(this.index);
  @override
  _PassengerFieldsState createState() => _PassengerFieldsState();
}

class _PassengerFieldsState extends State<PassengerFields> {
  TextEditingController _nameController;
  Gender _gender = Gender.male;
  DateTime _dob = DateTime.now();
  Map data = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          MyCustomFormState.passengerList[widget.index] ?? '';
    });

    final popup = BeautifulPopup(
      context: context,
      template: TemplateAuthentication,
    );
    data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      _dob == null ? data['dob'] : _dob;
    }

    return Column(children: [
      TextFormField(
        controller: _nameController,
        onChanged: (v) => MyCustomFormState.passengerList[widget.index] = v,
        decoration: const InputDecoration(
          icon: const Icon(Icons.account_box_outlined),
          hintText: 'Enter title (Mr, Mrs)',
          labelText: 'Title',
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
      TextFormField(
        controller: _nameController,
        onChanged: (v) => MyCustomFormState.passengerList[widget.index] = v,
        decoration: const InputDecoration(
          icon: const Icon(Icons.account_box_outlined),
          hintText: 'Enter first name',
          labelText: 'First Name',
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
      TextFormField(
        controller: _nameController,
        onChanged: (v) => MyCustomFormState.passengerList[widget.index] = v,
        decoration: const InputDecoration(
          icon: const Icon(Icons.account_box_outlined),
          hintText: 'Enter last name',
          labelText: 'Last Name',
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
      Column(children: <Widget>[
        ListTile(
          title: const Text('Male'),
          leading: Radio(
            value: Gender.male,
            groupValue: _gender,
            onChanged: (Gender value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio(
            value: Gender.female,
            groupValue: _gender,
            onChanged: (Gender value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
      ]),
      FlatButton(
            color: Colors.white,
            //padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            onPressed: () {
              return showDatePicker(
                context:context,
                initialDate:_dob== null? 
                            DateTime.now():_dob,
                firstDate: DateTime(2020), 
                lastDate: DateTime(2022)).then((date){
                  setState(() {
                    _dob=date;
                    print(_dob.month);
                    print(_dob.runtimeType);
                  });
                });
            },
            child: buildDateSelector('Date Of Birth', _dob),
        ),
    ]);
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


}

/* 
EMAIL AND PHONE NUMBER ONLY ONCE

	"ContactNo":"9632587410",
	"Email":"support@srdvtechnologies.com",

  "Title":"Mr",
	"FirstName":"SRDV",
	"LastName":"Support",
	"PaxType":"1",
	"DateOfBirth":"",
	"Gender":"1",
	"PassportNo":"",
	"PassportExpiry":"",
	"AddressLine1":"Test",
	"City":"Kolkata",
	"CountryCode":"IN",
	"CountryName":"India",
	"IsLeadPax":"True",
	"Fare": {
    "BaseFare": 2526,
    "Tax": 920,
    "TransactionFee": "0",
    "YQTax": 400,
    "AdditionalTxnFeeOfrd": 0,
    "AdditionalTxnFeePub": 0,
    "AirTransFee": "0"
  }

*/
