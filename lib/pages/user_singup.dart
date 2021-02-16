import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

enum SingingCharacter { M, F }

class SignupFormValidation extends StatefulWidget {
  @override
  _SignupFormValidationState createState() => _SignupFormValidationState();
}

class _SignupFormValidationState extends State<SignupFormValidation> {
  final dio = new Dio();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SingingCharacter _userGender = SingingCharacter.M;



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
                    text: 'Registration ',
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
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter fullname'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      // EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        hintText: 'Enter valid phone number'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      // EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 0),
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
              ListTile(
                title: const Text('Male'),
                leading: Radio(
                value: SingingCharacter.M,
                groupValue: _userGender,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _userGender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio(
                value: SingingCharacter.F,
                groupValue: _userGender,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _userGender = value;
                  });
                },
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
                      _singup(emailController.text,nameController.text,phoneController.text, passwordController.text);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomePage()));
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text('Existing User'),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                  Navigator.pushNamed(context, '/user_login');
                },
                child: Text(
                  'Back to Login',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _singup(email,name,phone,password) async {
    print(email);
    print(password);
    var url ="http://demo.softgneer.com/bookingapp/api_v1/customer/singup";


    dio.options.headers['x-api-key'] = 'bookingapp';
    FormData formData = new FormData.from({
      "email": email,
      "name":name,
      "phone":phone,
      "password": password,
      "gender":_userGender
    });
    final response = await dio.post(url,data:formData);
    if(response.data['status']==0){
      _showMyDialog("Singup Error",response.data['error_message'],0);

    }else{
      _showMyDialog("Thank You!!!","You are successfully registerd with us.login to manage account",1);

    }


  }

  Future<void> _showMyDialog(heading,message,type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
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
                if(type==0) {
                  Navigator.of(context).pop();
                }else{
                  Navigator.pushNamed(context, '/');
                }

              },
            ),
          ],
        );
      },
    );
  }
}