import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Constant variable for culor and other settings
const primaryAppbarbg= '#175BA2';
const mBackgroundColor = Color(0xFFFAFAFA);
const mBlueColor = Color(0xFF2C53B1);
const mGreyColor = Color(0xFFB4B0B0);
const mTitleColor = Color(0xFF23374D);
const mSubtitleColor = Color(0xFF8E8E8E);
const mBorderColor = Color(0xFFE8E8F3);
const mFillColor = Color(0xFFFFFFFF);
const mCardTitleColor = Color(0xFF2E4ECF);
const appbarcurveheight=10.0;



// Functions
String returnDateMonthName(int monthindex){
  final month = ["",'Jan', 'Feb', 'March','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  final monthMap = month.asMap(); // {0: 'apple', 1: 'orange', 2: 'mango'}
  // To access 'orange' use the index 1.
  final month_name = monthMap[monthindex]; // 'orange'
  return month_name;
}

String returnWeekDayName(int dayindex){
  final day = ["",'Monday', 'Tueday', 'Wednesday','Thrusday','Friday','Saturday','Sunday'];
  final dayMap = day.asMap(); // {0: 'apple', 1: 'orange', 2: 'mango'}
  final day_name = dayMap[dayindex]; // 'orange'
  return day_name;
}




class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder(this.curveHeight);
  final double curveHeight;
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + curveHeight * 2,
      rect.size.width,
      rect.size.height,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}


class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String titleText;

  const Customappbar({
    Key key,
    @required this.height,this.titleText,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          color: HexColor(primaryAppbarbg),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: AppBar(
              elevation: 0,
              backgroundColor: HexColor(primaryAppbarbg),
              shape: const MyShapeBorder(appbarcurveheight),
              title: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    children: [
                      TextSpan(
                          text: titleText,
                          style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: '',
                          style: GoogleFonts.overpass(fontWeight: FontWeight.w400)),

                    ]),
              ),
            ) ,
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(height);
}


class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);

    //A bezier path for clipping
    var firstEndPoint = Offset(size.width/2, size.height - 30);
    var firstControlPoint = Offset(size.width/4, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 80);
    var secondControlPoint = Offset(size.width * 0.8, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
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
