import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flight_booking_flutter_app/models/AirportInfo.dart';
import 'package:flight_booking_flutter_app/pages/flight_search_page.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _imageHeight = 256.0;
  var _imagePath="https://images.pexels.com/photos/1430673/pexels-photo-1430673.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
          children: <Widget>[
          _buildIamge(),
          _buildTopHeader(),
          _buildProfileRow(),

          // Container(height: 1, color: Colors.black26),
          // FlatButton(
          //   color: Colors.white,
          //   padding: EdgeInsets.all(24),
          //   onPressed: () {
          //     Navigator.pushNamed(context, "/flight");
          //   },
          //   child:
          //   Text(
          //     'Bus Booking',
          //     style: GoogleFonts.overpass(
          //         fontSize: 18, color: Colors.grey),
          //   )
          // ),
          Container(height: 1, color: Colors.black26),

          ],
        ),
      );

  }

  Widget _buildIamge() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
      child: new Image.network(
        _imagePath,
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }
  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Timeline",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }
  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
              minRadius: 28.0,
              maxRadius: 28.0,
              backgroundImage: new NetworkImage('https://img.favpng.com/2/24/1/airplane-aircraft-cartoon-icon-png-favpng-unVRHE9Dn8KEy1KbKS69xCfCc.jpg')
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
              child:new Column(
                children: <Widget>[
                  new CircleAvatar(
                      minRadius: 28.0,
                      maxRadius: 28.0,
                      backgroundImage: new NetworkImage('data:image/png;base64,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')
                  )
                ],
              ),
          ),


          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Ryan Barnes',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Product designer',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


class DemoItem extends StatelessWidget {
  final String title;
  final String route;
  DemoItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}

class CarouselDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel demo'),),
      body: ListView(
        children: <Widget>[
          DemoItem('Basic demo', '/basic'),
          DemoItem('No center mode demo', '/nocenter'),
          DemoItem('Image carousel slider', '/image'),
          DemoItem('More complicated image slider', '/complicated'),
          DemoItem('Enlarge strategy demo slider', '/enlarge'),
          DemoItem('Manually controlled slider', '/manual'),
          DemoItem('Noon-looping carousel slider', '/noloop'),
          DemoItem('Vertical carousel slider', '/vertical'),
          DemoItem('Fullscreen carousel slider', '/fullscreen'),
          DemoItem('Carousel with indicator demo', '/indicator'),
          DemoItem('On-demand carousel slider', '/ondemand'),

        ],
      ),
    );
  }
}
class BasicDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> list = [1,2,3,4,5];
    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(),
            items: list.map((item) => Container(
              child: Center(
                  child: Text(item.toString())
              ),
              color: Colors.green,
            )).toList(),
          )
      ),
    );
  }
}

class NoCenterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> list = [1,2,3,4,5];
    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              disableCenter: true,
            ),
            items: list.map((item) => Container(
              child: Text(item.toString()),
              color: Colors.green,
            )).toList(),
          )
      ),
    );
  }
}

class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image slider demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(),
            items: imgList.map((item) => Container(
              child: Center(
                  child: Image.network(item, fit: BoxFit.cover, width: 1000)
              ),
            )).toList(),
          )
      ),
    );
  }
}

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();

class ComplicatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Complicated image slider demo')),
      body: Container(
          child: Column(children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          ],)
      ),
    );
  }
}

class EnlargeStrategyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Complicated image slider demo')),
      body: Container(
          child: Column(children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: imageSliders,
            ),
          ],)
      ),
    );
  }
}

class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Manually controlled slider')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(enlargeCenterPage: true, height: 200),
                carouselController: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: RaisedButton(
                      onPressed: () => _controller.previousPage(),
                      child: Text('←'),
                    ),
                  ),
                  Flexible(
                    child: RaisedButton(
                      onPressed: () => _controller.nextPage(),
                      child: Text('→'),
                    ),
                  ),
                  ...Iterable<int>.generate(imgList.length).map(
                        (int pageIndex) => Flexible(
                      child: RaisedButton(
                        onPressed: () => _controller.animateToPage(pageIndex),
                        child: Text("$pageIndex"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}

class NoonLoopingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noon-looping carousel demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 2,
              autoPlay: true,
            ),
            items: imageSliders,
          )
      ),
    );
  }
}

class VerticalSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vertical sliding carousel demo')),
      body: Container(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
              autoPlay: true,
            ),
            items: imageSliders,
          )
      ),
    );
  }
}

class FullscreenSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList.map((item) => Container(
              child: Center(
                  child: Image.network(item, fit: BoxFit.cover, height: height,)
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}

class OnDemandCarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('On-demand carousel demo')),
      body: Container(
          child: CarouselSlider.builder(
            itemCount: 100,
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            itemBuilder: (ctx, index) {
              return Container(
                child: Text(index.toString()),
              );
            },
          )
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel with indicator demo')),
      body: Column(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ]
      ),
    );
  }
}