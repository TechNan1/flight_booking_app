import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/widgets/destination_carousel.dart';

class NestedTabBar extends StatefulWidget {

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.redAccent,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.black54,

          isScrollable: true,

          tabs: <Widget>[
            Tab(
              text: "All",
            ),
            Tab(
              text: "Domestics",
            ),
            Tab(
              text: "Internationals",
            ),

          ],
        ),

        Container(
          height: screenHeight * 0.40,
          margin: EdgeInsets.only(left: 0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                child:
                DestinationCarousel(),
              ),
              Container(
                child:
                DestinationCarousel(),
              ),
              Container(
                child:
                DestinationCarousel(),
              ),


            ],
          ),
        )
      ],
    );
  }
}