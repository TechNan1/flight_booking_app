import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking_flutter_app/pages/common.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ProfilePage> {
  Map data = {};
  Color color = Colors.indigo;
  int _selectedIndex = 0;
  int _currentTab = 0;
  final dio = new Dio();

  String _name = "";
  String _email = "";
  String _phone = "";
  String _email_verify = "";
  String _phone_verify = "";
  String _profile_pic = "";

  @override
  Widget build(BuildContext context) {
    check_is_login();
    data = ModalRoute
        .of(context)
        .settings
        .arguments;
    String user_id = data['user_id'];
    _getprofile(user_id);
    const curveHeight = 10.0;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        shape: const MyShapeBorder(curveHeight),
        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 24),
              children: [
                TextSpan(
                    text: 'My ',

                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),
                TextSpan(
                    text: 'Profile',
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),

              ]),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.vexels.com/media/users/3/148199/isolated/preview/8d2266d10c0de8283c9f225d7f7b045b-colorful-abstract-geometric-background-vector-by-vexels.png"),
                      fit: BoxFit.cover
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_profile_pic),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              _name
              , style: TextStyle(
                fontSize: 25.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400
            ),
            ),
            Container(height: 1, color: Colors.black,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildButtonColumn(
                    color, FontAwesomeIcons.pencilAlt, 'Edit', '/user_edit'),),
                Expanded(child: _buildButtonColumn(
                    color, FontAwesomeIcons.bookOpen, 'Booking',
                    '/user_bookinng'),),
                Expanded(child: _buildButtonColumn(
                    color, FontAwesomeIcons.signOutAlt, 'LogOut',
                    '/user_logout'),),

              ],
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 20,
            ),
            buildDetailView('Email', _email),
            buildVerifyEmailOption(_email_verify),

            buildDetailView('Phone', _phone),
            buildVerifyPhoneOption(_phone_verify),

            buildDetailView('Gender', ''),
            buildDetailView('DOB', ''),
            buildDetailView('Address', ''),
            buildDetailView('City', ''),
            buildDetailView('Zip', ''),
            buildDetailView('State', ''),
            buildDetailView('Country', ''),

            SizedBox(
              height: 100,
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
          switch (_currentTab) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              break;
            case 2:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.workspaces_filled,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                  'https://cdn1.iconfinder.com/data/icons/technology-devices-2/100/Profile-512.png'),
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  void _getprofile(user_id) async {
    dio.options.headers['x-api-key'] = 'bookingapp';
    FormData formData = new FormData.from({
      "id": user_id,

    });
    final response = await dio.post(
        'http://demo.softgneer.com/bookingapp/api_v1/customer/profile',
        data: formData);
    if (response.data['status'] == 0) {
      _showMyDialog(response.data['error_message']);
    } else {
      setState(() {
        _email = response.data['data']['detail']['email'];
        _name = response.data['data']['detail']['fullname'];
        _phone = response.data['data']['detail']['phone'];
        _email_verify = response.data['data']['detail']['is_email_verify'];
        _phone_verify = response.data['data']['detail']['is_phone_verify'];
        if (response.data['data']['detail']['profile_pic'] != null) {
          _profile_pic = response.data['data']['detail']['profile_pic'];
        } else {
          _profile_pic =
          'https://www.pngkey.com/png/full/115-1150152_default-profile-picture-avatar-png-green.png';
        }
      });
    }
  }

  Widget _buildButtonColumn(Color color, IconData icon, String label,
      String route) {
    if(label=="LogOut"){
      return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, route);
          showAlertDialog(context);

        },
        child: Container(

          decoration: BoxDecoration(

            border: Border(
              right: BorderSide( //                   <--- left side
                color: HexColor("DADADA"),
                width: 1.0,
              ),
              bottom: BorderSide( //                    <--- top side
                color: HexColor("DADADA"),
                width: 1.0,

              ),), // set border width
            // make rounded corner of border
          ),
          padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 20.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(icon, color: color, size: 20),

              Container(
                margin: const EdgeInsets.only(top: 8),

                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor("000000"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(

        decoration: BoxDecoration(

          border: Border(
            right: BorderSide( //                   <--- left side
              color: HexColor("DADADA"),
              width: 1.0,
            ),
            bottom: BorderSide( //                    <--- top side
              color: HexColor("DADADA"),
              width: 1.0,

            ),), // set border width
          // make rounded corner of border
        ),
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 20.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, color: color, size: 20),

            Container(
              margin: const EdgeInsets.only(top: 8),

              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor("000000"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
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


  Widget buildDetailView(String heading, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                heading,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 120.0),
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w200
                    ),),
                ),


              ],
            ),

          ],
        ),
      ],
    );
  }

  Widget buildVerifyEmailOption(String value) {
    if (value == '0') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'Not Verified yet',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),


            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      print("print on verify email");
                    },
                    child: Text(
                      'Verify Now',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  )
              ),


            ],
          ),

        ],
      );
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      Padding(
            padding:EdgeInsets.only(left: 20.0, right: 10.0),
            child: Text(
              'Verified',
              style: TextStyle(
                color: Colors.green,
                fontSize: 15.0,
                fontWeight: FontWeight.w600
              ),
            ),
          )
          ],
        ),
      ],
    );
  }

  }


  Widget buildVerifyPhoneOption(String value) {
    if (value == '0') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'Not Verified yet',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),


            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      print("print on verify phone");
                    },
                    child: Text(
                      'Verify Now',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  )
              ),


            ],
          ),

        ],
      );
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Padding(
      padding:EdgeInsets.only(left: 20.0, right: 10.0),
    child: Text(
    'Verified',
    style: TextStyle(
    color: Colors.green,
    fontSize: 15.0,
    fontWeight: FontWeight.w600
    ),
    ),)

    ],
    ),
    ],
    );
  }

  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Logout"),
      onPressed:  () {
        process_logout();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("LogOut"),
      content: Text("Would you like to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void process_logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', null);
    prefs.setString('user_name', null);
    prefs.setString('user_email', null);
    prefs.setString('user_phone', null);
    Navigator.pushNamed(context, '/');

  }

  void check_is_login() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String user_id = prefs.getString('user_id');
    // if(user_id==null)
    // {
    //   Navigator.pushNamed(context, '/');
    // }

  }


}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}