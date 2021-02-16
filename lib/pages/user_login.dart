import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';


class LoginFormValidation extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  final dio = new Dio();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        shape: const MyShapeBorder(10.0),
        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 24),
              children: [
                TextSpan(
                    text: 'Login ',

                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),
                TextSpan(
                    text: '',
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),

              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidate: true, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.network('https://9to5google.com/wp-content/uploads/sites/4/2020/06/google_photos_logo_2020.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email/Phone',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                     // EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                          "Password should not be greater than 15 characters")
                    ])
                  //validatePassword,        //Function to check validation
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formkey.currentState.validate()) {
                      _login(emailController.text, passwordController.text);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text('New User? Create Account'),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                  Navigator.pushNamed(context, '/user_singup');
                },
                child: Text(
                  'SingUp Now',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(email,password) async {
    print(email);
    print(password);
    var url ="http://demo.softgneer.com/bookingapp/api_v1/customer/login";


    dio.options.headers['x-api-key'] = 'bookingapp';
    FormData formData = new FormData.from({
      "email_phone": email,
      "password": password,
     });
    final response = await dio.post(url,data:formData);
    if(response.data['status']==0){
      _showMyDialog(response.data['error_message']);

    }else{
      save_login(response.data['data']['detail']['id'],response.data['data']['detail']['fullname'],response.data['data']['detail']['email'],response.data['data']['detail']['pphone'],);
      Navigator.pushNamed(context, '/');
    }
    // print(response.data);
    // print(response.data['data']['detail']['fullname']);


  }

  void save_login(user_id,user_name,user_email,user_phone) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', user_id);
    prefs.setString('user_name', user_name);
    prefs.setString('user_email', user_email);
    prefs.setString('user_phone', user_phone);
  }

  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loging Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}