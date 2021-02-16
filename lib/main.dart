import 'package:flight_booking_flutter_app/pages/select_traveler.dart';
import 'package:flight_booking_flutter_app/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/flight_search_page.dart';
import 'package:flight_booking_flutter_app/pages/hotel_search_page.dart';
import 'package:flight_booking_flutter_app/pages/bus_search_page.dart';
import 'package:flight_booking_flutter_app/pages/home_screen.dart';
import 'package:flight_booking_flutter_app/pages/choose.dart';
import 'package:flight_booking_flutter_app/pages/flight_search_list.dart';
import 'package:flight_booking_flutter_app/pages/user_login.dart';
import 'package:flight_booking_flutter_app/pages/user_singup.dart';
import 'package:flight_booking_flutter_app/pages/splash_screen.dart';
import 'package:flight_booking_flutter_app/pages/user_profile.dart';


void main() {
  runApp(BookingApp());

}

class BookingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFffffff),
      ),
      initialRoute: '/splash',
      routes: {
        '/': (ctx) => HomeScreen(),
        '/flight': (ctx) => FlightSearchPage(),
        '/hotels':(ctx)=> HotelSearchPage(),
        '/bus':(ctx)=> BusSearchPage(),
        '/choose_airport_from': (ctx) => ChooseFlightSource(),
        '/select_traveler': (ctx) => SelectTraveler(),
        '/flight_results':(ctx) => FlightList(),
        '/user_login':(ctx) => LoginFormValidation(),
        '/user_singup':(ctx) => SignupFormValidation(),
        '/user_profile':(ctx) => ProfilePage(),
        '/splash':(ctx)=>SplashScreen(),


      },
    );
  }
}
