import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SelectTraveler extends StatefulWidget {
  SelectTraveler({ Key key ,this.traveler,this.atraveler,this.itraveler,this.ctraveler}) : super(key: key);
  final int traveler;
  final int atraveler;
  final int ctraveler;
  final int itraveler;
  @override
  _SelectTravelerState createState() => new _SelectTravelerState();
}

class _SelectTravelerState extends State<SelectTraveler> {


  String _travel_class="Economy";
  Map data={};
  int _no_of_traveler=1;
  int _no_of_atraveler=1;
  int _no_of_ctraveler=0;
  int _no_of_itraveler=0;


  int calculateTotal(int a,int c, int i)
  {
    int t=a+c+i;
    print(t);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar:Customappbar(height: 70,titleText: "Update Traveler & Class",),
      body: SafeArea(
        child: ListView(
          children: [
            Container(height: 20,),
            Row(
              children: [
                Text("Total Person:",style: GoogleFonts.overpass(
                    fontSize: 36, color: Colors.grey)),
                SizedBox(width: 30,),
                Text("$_no_of_traveler",style: GoogleFonts.overpass(
                    fontSize: 36, color: Colors.grey))
              ],
            ),
            SizedBox(height: 30,),
            Column(
              children: [
                Row(
                  children: [
                    Text("Update Traveler"),
                  ],
                ),
                Container(height: 1, color: Colors.black26),
                Row(
                  // mainAxisSize: MainAxisSize.,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      buildTravelerSelector("Adult",_no_of_atraveler),
                      buildTravelerSelectorOperation("Adult",_no_of_atraveler,_no_of_ctraveler,_no_of_itraveler),
                    ]
                ),
                Container(height: 1, color: Colors.black26),
                Row(
                  // mainAxisSize:,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      buildTravelerSelector("Child",_no_of_ctraveler),
                      buildTravelerSelectorOperation("Child",_no_of_ctraveler,_no_of_ctraveler,_no_of_itraveler),
                    ]
                ),
                Container(height: 1, color: Colors.black26),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      buildTravelerSelector("Infant",_no_of_itraveler),
                      buildTravelerSelectorOperation("Infant",_no_of_itraveler,_no_of_ctraveler,_no_of_itraveler),
                    ]
                ),
                Row(
                  children: [
                    Text("Update Class"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            Text("Traveling Class:"),
                            Text("$_travel_class",style: GoogleFonts.overpass(
                                fontSize: 36, color: Colors.grey))

                          ],
                        )
                    ),
                    Expanded(child:
                    Column(
                      children: [
                        DropdownButton(
                            value: _travel_class,
                            items: [
                              DropdownMenuItem(
                                child: Text("Economy Class"),
                                value: "Economy",
                              ),
                              DropdownMenuItem(
                                child: Text("Premuim Class"),
                                value: "Premium",
                              ),
                              DropdownMenuItem(
                                  child: Text("Bussiness Class"),
                                  value: "Bussiness"
                              ),
                              DropdownMenuItem(
                                  child: Text("First Class"),
                                  value: "First"
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _travel_class = value;
                              });
                            }),
                      ],
                    )
                    )
                  ],
                ),
                Container(height: 1, color: Colors.black26),
              ],
            ),


            SizedBox(height: 30,),
            Center(
                child: Column(
                  children: [
                    RaisedButton(
                      child: Text(
                        "Update",
                        style: GoogleFonts.overpass(fontSize: 24),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/flight',arguments: {
                          'traveler_update':"yes",
                          'total_person':_no_of_traveler,
                          'total_adult':_no_of_atraveler,
                          'total_child':_no_of_ctraveler,
                          'total_infant':_no_of_itraveler,

                          'travel_class':_travel_class,

                          'airportFromCode': data['fromiata'],
                          'airportFromLongName': data['fromname'],
                          'airportFromShortName': data['fromcity'],
                          'airportToCode': data['toiata'],
                          'airportToLongName': data['toname'],
                          'airportToShortName': data['tocity'],


                        });
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(80, 15, 90, 15),
                      splashColor: Colors.grey,
                    ),
                  ],
                )
            )

          ],
        ) ,
      ),

    );
  }


  Widget buildTravelerSelector(String title,int count) {

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

  Widget buildTravelerSelectorOperation(String title ,int a,int c,int i) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            new FlatButton(
              onPressed:(){
                int t=calculateTotal(_no_of_atraveler, _no_of_ctraveler, _no_of_itraveler);
                if(t>8)
                {
                  AwesomeDialog(
                    context: context,
                    headerAnimationLoop: false,
                    dialogType: DialogType.NO_HEADER,
                    title:"Total Traveler Limit exceeded",
                    desc: "total count of person should be 9 or less",
                    btnOkOnPress: () {
                      debugPrint('OnClcik');
                    },
                    btnOkIcon: Icons.check_circle,
                  )..show();
                }else{
                  setState(() {
                    print(title);
                    print(t);
                    _no_of_traveler=t;
                    if(title=="Adult")
                    {
                      print(_no_of_atraveler);
                      if (_no_of_atraveler <= 9) {
                        _no_of_atraveler++;
                        print("=====");
                      }

                    }
                    if(title=="Child")
                    {
                      if (_no_of_ctraveler <= 9)
                        _no_of_ctraveler++;
                    }
                    if(title=="Infant")
                    {
                      if (_no_of_itraveler <= 9)
                        _no_of_itraveler++;
                    }
                    t =calculateTotal(_no_of_atraveler, _no_of_ctraveler, _no_of_itraveler);
                    _no_of_traveler=t;
                  });
                }
              },


              child: new Icon(
                  Icons.add,
                  color: Colors.black),
            ),
            Text(""),
            new FlatButton(
              onPressed: (){
                setState(() {
                  if(title=="Adult"){
                    if (_no_of_atraveler != 1)
                      _no_of_atraveler--;
                  }
                  if(title=="Child"){
                    _no_of_ctraveler--;
                  }
                  if(title=="Infant"){
                    _no_of_itraveler--;
                  }
                  int t =calculateTotal(_no_of_atraveler, _no_of_ctraveler, _no_of_itraveler);
                  _no_of_traveler=t;

                });
              },
              child: new Icon(
                  Icons.remove,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      print(data);
      // if(data != null) {
      //   _no_of_traveler=data['total_person'];
      //   _travel_class=data['travel_class'];
      //   _no_of_atraveler=data['total_adult'];
      //   _no_of_ctraveler=data['total_child'];
      //   _no_of_itraveler=data['total_infant'];
      // }

    });

  }
}

