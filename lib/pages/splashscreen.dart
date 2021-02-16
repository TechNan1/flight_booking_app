import 'package:flutter/material.dart';
import "dart:async";


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=>{
      Navigator.of(context).pushReplacementNamed('/')
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: new Image.network(
                'https://demo.softgneer.com/bookingapp/images/app/demmast1.jpeg',
                height: 125.0,
                fit: BoxFit.scaleDown,
              ),
            ),

            // Text("Start Whatsapp Chat",style: TextStyle(color: Colors.white,fontSize: 25),),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}