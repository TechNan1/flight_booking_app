import 'package:flutter/material.dart';
import 'package:flight_booking_flutter_app/models/deal_modal.dart';

class DealCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Exclusive Deals',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => print('See All'),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: deals.length,
            itemBuilder: (BuildContext context, int index) {
              Deal deal = deals[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                width: screenWidth * 0.90,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    // Positioned(
                    //   bottom: 15.0,
                    //   child: Container(
                    //     height: 120.0,
                    //     width: 240.0,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(10.0),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: <Widget>[
                    //           Text(
                    //             deal.name,
                    //             style: TextStyle(
                    //               fontSize: 22.0,
                    //               fontWeight: FontWeight.w600,
                    //               letterSpacing: 1.2,
                    //             ),
                    //           ),
                    //           SizedBox(height: 2.0),
                    //           Text(
                    //             deal.address,
                    //             style: TextStyle(
                    //               color: Colors.grey,
                    //             ),
                    //           ),
                    //           SizedBox(height: 2.0),
                    //           Text(
                    //             '\$${deal.price} ',
                    //             style: TextStyle(
                    //               fontSize: 18.0,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: deal.imageUrl,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Image(
                                height: 210.0,
                                width: screenWidth,
                                image: NetworkImage(deal.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            top: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  deal.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Row(
                                  children: <Widget>[
                                    // Icon(
                                    //   // FontAwesomeIcons.locationArrow,
                                    //   size: 10.0,
                                    //   color: Colors.white,
                                    // ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      deal.address,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
