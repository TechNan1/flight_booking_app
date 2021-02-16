import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/material.dart';


class FlightResultInfo {
  final String TraceId;
  final String SrdvType;
  final String Origin;
  final String Destination;
  // final List<Results> results;
  FlightResultInfo({this.TraceId, this.SrdvType, this.Origin,this.Destination});

  factory FlightResultInfo.fromJson(Map<String,dynamic> json) {

    return FlightResultInfo(
      TraceId: json['data']['TraceId'],
      SrdvType: json['data']['SrdvType'],
      Origin: json['data']['Origin'],
      Destination: json['data']['Destination'],
      // results: List<Results>.from(json["Results"].map((x) => Results.fromJson(x))),
    );

  }
  Map<String, dynamic> toJson() => {
    "TraceId": TraceId,
    "SrdvType": SrdvType,
    "Origin": Origin,
    "Destination": Destination,
  };
}

FlightResultInfo getInfo(response) {
  final jsonData = response;

  return FlightResultInfo.fromJson(jsonData);
}


class FlightResults {
  String SrdvIndex;
  String ResultIndex;
  String Source;
  String AirlineRemark;
  String Fare_Currency;
  String Fare_PublishedFare;
  String Fare_OfferedFare;
  String Segments_Airline_airlinecode;
  String Segments_Airline_airlinename;
  String Segments_Airline_airlinenumber;
  String Segments_Origin_airportcode;
  String Segments_Origin_airportname;
  String Segments_Origin_citycode;
  String Segments_Origin_cityname;
  String Segments_departfulldate;
  String Segments_departtime;
  String Segments_Destination_airportcode;
  String Segments_Destination_airportname;
  String Segments_Destination_citycode;
  String Segments_Destination_cityname;
  String Segments_arrivalfulldate;
  String Segments_arrivaltime;
  String Segments_Duration;
  String Segments_GroundTime;
  String Segments_StopOver;



  FlightResults({
    this.SrdvIndex,
    this.ResultIndex,
    this.AirlineRemark,
    this.Fare_Currency,
     this.Fare_PublishedFare,
    this.Fare_OfferedFare,
    this.Segments_Airline_airlinecode,
    this.Segments_Airline_airlinename,
    this.Segments_Airline_airlinenumber,
    this.Segments_Origin_airportcode,
    this.Segments_Origin_airportname,
    this.Segments_Origin_citycode,
    this.Segments_Origin_cityname,
    this.Segments_departfulldate,
    this.Segments_departtime,
    this.Segments_Destination_airportcode,
    this.Segments_Destination_airportname,
    this.Segments_Destination_citycode,
    this.Segments_Destination_cityname,
    this.Segments_arrivalfulldate,
    this.Segments_arrivaltime,
    this.Segments_Duration,
    this.Segments_GroundTime,
    this.Segments_StopOver,
  });

  factory FlightResults.fromJson(Map<String, dynamic> json) => FlightResults(
    SrdvIndex: json["SrdvIndex"],
    ResultIndex: json["ResultIndex"],
      AirlineRemark: json["AirlineRemark"],
      Fare_Currency: json["Fare_Currency"],
     Fare_PublishedFare: json["Fare_PublishedFare"].toString(),
      Fare_OfferedFare: json["Fare_OfferedFare"].toString(),
      Segments_Airline_airlinecode: json["Segments_Airline_airlinecode"],
      Segments_Airline_airlinename:json["Segments_Airline_airlinename"],
      Segments_Airline_airlinenumber:json["Segments_Airline_airlinenumber"],
      Segments_Origin_airportcode: json["Segments_Origin_airportcode"],
      Segments_Origin_airportname: json["Segments_Origin_airportname"],
      Segments_Origin_citycode: json["Segments_Origin_citycode"],
      Segments_Origin_cityname: json["Segments_Origin_cityname"],
      Segments_departfulldate: json["Segments_departfulldate"],
      Segments_departtime: json["Segments_departtime"],
      Segments_Destination_airportcode: json["Segments_Destination_airportcode"],
      Segments_Destination_airportname: json["Segments_Destination_airportname"],
      Segments_Destination_citycode: json["Segments_Destination_citycode"],
      Segments_Destination_cityname: json["Segments_Destination_cityname"],
      Segments_arrivalfulldate: json["Segments_arrivalfulldate"],
      Segments_arrivaltime: json["Segments_arrivaltime"],
      Segments_Duration: json["Segments_Duration"].toString(),
      Segments_GroundTime: json["Segments_GroundTime"].toString(),
      Segments_StopOver: json["Segments_StopOver"].toString()


  );

  // Map<String, dynamic> toJson() => {
  //   "id": SrdvIndex,
  //   "mobile": ResultIndex,
  //
  // };

}

List<FlightResults> allresults(respone) {
  final result = respone;
  if(result['error']!=1){
    Iterable list = result['data']['Results'];
    return list.map((model) => FlightResults.fromJson(model)).toList();

  }else{
    print(result['error_message']);
    return [];
  }

}