import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flurry_navigation/flurry_navigation.dart';

final Screen firstscreen = new Screen(
    contentBuilder: (BuildContext context) {
      return new Center(
        child: new Container(
          child: new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical:100),
            child: new Column(
              children:[
                new Expanded(
                  child:ImageCarousel()
                ),
               new Expanded(
                    child: new Center(
                        heightFactor: 10,
                        child: new Text('Welcome help the helpinghands')
                    )
                ) 
              ]
            )
          ),
        ),
      );
    }
);

class ImageCarousel extends StatefulWidget {
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    Widget carousel = new Carousel(
      boxFit: BoxFit.cover,
      images: [
        new AssetImage('assets/images/1.jpeg'),
        new AssetImage('assets/images/2.jpeg'),
        new AssetImage('assets/images/3.jpeg'),
        new AssetImage('assets/images/4.jpeg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(seconds: 1),
    );

    Widget banner = new Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
        child: new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            color: Colors.amber.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(10.0),
          child: new Text(
            'Helping Hand',
            style: TextStyle(
              fontFamily: 'fira',
              fontSize: animation.value,//18.0,
              //color: Colors.white,
            ),
          ),
        ),
      // ),
    //  ),
    );

    return new Scaffold(
      backgroundColor: Colors.white12,
      body: new Center(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          height: screenHeight / 2,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: new Stack(
              children: [
                carousel,
                banner,
              ],
            ),
          ),
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}