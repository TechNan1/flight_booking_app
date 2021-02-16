import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/models/flight_model.dart';


  Future getData(int adult,int child,int infant,int type,String origin, String destination,String pdt,String pat,int cls) async{
    final dio = new Dio();
    print(pat);
    print(pdt);
    var url ="https://demo.softgneer.com/bookingapp/api_v1/flight/search";
    dio.options.headers['x-api-key'] = 'bookingapp';
    FormData formData = new FormData.from({
      "Adult": adult,
      "Child":child,
      "Infant":infant,
      "Type": type,
      "Origin":origin,
      "Destination":destination,
      "PDT":pdt,
      "PAT":pat,
      "Class":cls
    });
    final response = await dio.post(url,data:formData);
    return response;
    // return getInfo(response.data);
  }

 Future<FlightResultInfo> getflightinfo(int adult,int child,int infant,int type,String origin, String destination,String pdt,String pat,int cls) async{
   final response = await getData(adult,child,infant,type,origin, destination,pdt,pat,cls);
   return getInfo(response.data);
 }

Future<List<FlightResults>> allflightlist(int adult,int child,int infant,int type,String origin, String destination,String pdt,String pat,int cls) async {
  final response = await getData(adult,child,infant,type,origin, destination,pdt,pat,cls);
   return allresults(response.data);

}

