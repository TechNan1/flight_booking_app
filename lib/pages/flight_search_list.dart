
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking_flutter_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:flight_booking_flutter_app/models/flight_model.dart';
import 'package:flight_booking_flutter_app/services/flight_search.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


enum TripType { oneway, roundtrip, multicity }




class FlightList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> {

  List<FlightResults> _flightResults = List<FlightResults>();
  String _traceId;
  String _srvdType;
  String _pdt="";
  String _pat="";
  String _origin;
  String _destination;
  int _adult;
  int _child;
  int _infant;
  int _type;
  int _bookingclass;
  DateTime _returndate;
  DateTime _departdate;



  Map data={};

  @override
  void initState() {
    Future.delayed(Duration.zero ,(){
      setState(() {
        data = ModalRoute
            .of(context)
            .settings
            .arguments;
        print(data);

        if (data != null) {
          _origin = data['fromiata'];
          _destination = data['toiata'];
          _adult = data['total_adult'];
          _child = data['total_child'];
          _infant = data['total_infant'];
          _type = data['trip'];
          if(data['travel_class']=="Economy")
          {
            _bookingclass = 1;
          }
          if(data['travel_class']=="Premium")
          {
            _bookingclass = 2;
          }
          if(data['travel_class']=="Bussiness")
          {
            _bookingclass = 3;
          }
          if(data['travel_class']=="First")
          {
            _bookingclass = 4;
          }
          _departdate = data['departDate'];
          _returndate = data['returnDate'];

          String month_str="";
          String day_str="";

          if(_departdate.month < 10)
            {
              month_str="0"+_departdate.month.toString();
            }else{
            month_str=_departdate.month.toString();
          }
          if(_departdate.day < 10)
          {
            day_str="0"+_departdate.day.toString();
          }else{
            day_str=_departdate.day.toString();
          }

          _pdt=_departdate.year.toString()+"-"+month_str+"-"+day_str+"T00:00:00";
          _pat=_departdate.year.toString()+"-"+month_str+"-"+day_str+"T00:00:00";
        }
      });
      _populateNewsArticles(_adult,_child,_infant,_type,_origin,_destination,_pdt,_pat,_bookingclass);
      _getsearchvalue(_adult,_child,_infant,_type,_origin,_destination,_pdt,_pat,_bookingclass);
    });
    super.initState();

    // _populateNewsArticles();

  }

  void _populateNewsArticles(int adult,int child,int infant,int type,String origin, String destination,String pdt,String pat,int cls) {
    allflightlist(adult,child,infant,type,origin, destination,pdt,pat,cls).then((flightresults) =>
        setState(() => {
           if(flightresults.length==0)
             {
            // Navigator.pop(context),
          AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          dialogType: DialogType.NO_HEADER,
          title:"No Flihght",
          desc: "Result not Found",
          btnOkOnPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
            print('OnClcik');
          },
          btnOkIcon: Icons.check_circle,
        )..show()
             }else{
             _flightResults = flightresults
           }

        })
    );

  }


  void _getsearchvalue(int adult,int child,int infant,int type,String origin, String destination,String pdt,String pat,int cls){
    getflightinfo(adult,child,infant,type,origin, destination,pdt,pat,cls).then((flightinfo) =>
        setState(() => {
          
          _traceId = flightinfo.TraceId,
          _srvdType = flightinfo.SrdvType

        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Customappbar(height: 70,titleText: "Fligh Results",),
        backgroundColor: mFillColor,
        body:  SafeArea(
            child: ListView(
            children:<Widget>[
               Container(height: 20,),
               buildSearchInfo(_origin,_destination,_departdate,_adult),
              Container(height: 2,color: Colors.black,),
               if(_flightResults.isEmpty)
                 LinearProgressIndicator(),
               ListView.builder(
                scrollDirection : Axis.vertical,
                 shrinkWrap: true,
                 physics: ScrollPhysics(),
                itemCount: _flightResults.length,
                itemBuilder: _buildItemsForListView,
              )
          ]
    ))

    );
  }

  Container _buildItemsForListView(BuildContext context, int index) {
    int d_hour =2;
    int d_minute=30;
    return Container(
      color: Colors.lightBlue,
      padding: const EdgeInsets.only(left:2),
      child:   buildAirportSelector(
            "",
            _flightResults[index].Segments_Airline_airlinename.toString(),
            _flightResults[index].Segments_Airline_airlinenumber.toString(),
            _flightResults[index].Segments_Airline_airlinecode.toString(),
            _flightResults[index].Segments_departtime,
            _flightResults[index].Segments_Origin_cityname,
            _flightResults[index].Segments_arrivaltime,
            _flightResults[index].Segments_Destination_cityname,
            d_hour,d_minute,
          _flightResults[index].Fare_Currency,
            double.parse(_flightResults[index].Fare_OfferedFare),
            double.parse(_flightResults[index].Fare_PublishedFare),
            _traceId,
            _srvdType,
            _flightResults[index].SrdvIndex,
            _flightResults[index].ResultIndex.toString(),
            )

      // title: Text(_flightResults[index].SrdvIndex),
      // subtitle: Text(_flightResults[index].SrdvIndex, style: TextStyle(fontSize: 18)),

    );
  }

  Widget buildSearchInfo(String from ,String to, DateTime depart,int person )
  {
      return Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(left: 20,bottom: 4,top: 0),
              child:   Row(
                children: [
                  Text("From:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22.0),),
                  Text(from,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  Text("--",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22.0),),
                  Text(to,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),

                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left:20),
              child:   Row(
                children: [

                  Text("Depart On :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22.0),),
                  Text(depart.day.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  Text("-",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  Text(depart.month.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  Text("-",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  Text(depart.year.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),
                  SizedBox(width: 15,),
                  Text("Person: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22.0),),
                  Text('$person',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w900,fontSize: 24.0),),

                ],
              ),
            ),



          ],
        ),
      );
  }


  Widget buildAirportSelector( String airline_logo,String airline,String flight_no,String airline_code,
      String depart_time,String origin_city,String arraival_time,
      String destination_city,int d_hour,int d_minute, String currency, double offer_price,double publish_price,String  trace_id,String srdv_type,String srdv_index,String result_index) {
    String dt=d_hour.toString()+"h "+d_minute.toString()+"m";
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child:Container(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Image(image:NetworkImage('https://pbs.twimg.com/profile_images/1263869715740389376/ev8EtB81.jpg'),height: 40,width: 40,)
                  ],
                ),
                SizedBox(width: 6,),
                SizedBox(
                  width:200,
                child:
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                      "$airline",
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: GoogleFonts.overpass(
                                          fontSize: 17,fontWeight: FontWeight.bold, color: Colors.black87),
                                    ),
                                  ),

                                  Text(

                                    "$airline_code-$flight_no",
                                    style: GoogleFonts.overpass(
                                        fontSize: 14, color: Colors.blueGrey),
                                  ),
                                ]
                            ),
                            SizedBox(width: 7,),
                            Column(
                              children: [
                                Text(
                                  "$depart_time",
                                  style: GoogleFonts.overpass(
                                      fontSize: 17,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    "$origin_city",
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: GoogleFonts.overpass(
                                        fontSize: 14, color: Colors.blueGrey),
                                  ) ,
                                )

                              ],
                            ),
                            SizedBox(width: 4,),
                            Padding(padding: EdgeInsets.only(top: 0),
                              child:
                              Text("-",style: GoogleFonts.overpass(
                                  fontSize: 17,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 4,),
                            Column(
                              children: [
                                Text(
                                  "$arraival_time",
                                  style: GoogleFonts.overpass(
                                      fontSize: 17,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    "$destination_city",
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: GoogleFonts.overpass(
                                        fontSize: 14, color: Colors.blueGrey),
                                  ),
                                )

                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.blueGrey,
                                size: 10,
                              ),

                            ),
                            Text("$dt",style: TextStyle(fontSize: 11),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
    ),
                SizedBox(width: 1,),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("$currency"),
                            Text("$offer_price",
                              softWrap: true,

                            )
                          ],
                        ),
                        SizedBox(height: 1,),
                        SizedBox(
                            width: 60,
                            height: 35,
                            child: RaisedButton(
                              elevation: 2,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              onPressed: () {
                                // print("booking press");
                                //
                                // print(trace_id);
                                // print(srdv_index);
                                // print(srdv_type);
                                // print(result_index);
                                AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.NO_HEADER,
                                  title:"Booking Flight",
                                  desc: "Work In Progress",
                                  btnOkOnPress: () {
                                    Navigator.pop(context);

                                    print('OnClcik');
                                  },
                                  btnOkIcon: Icons.check_circle,
                                )..show();

                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                    color: Color(0xFFE8E8E8), width: 1, style: BorderStyle.solid),
                              ),
                              color: Color(0XFF23417D),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Book",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                        )

                      ],
                    )
                  ],
                )

              ],
            )


        ),



      ),

    );

  }

}

