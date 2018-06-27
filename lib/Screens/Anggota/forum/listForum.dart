import 'package:flutter/material.dart';

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

   return new Center( 
      child: new Container(
      
      alignment: Alignment.bottomCenter,
      padding: new EdgeInsets.only(left: 8.0, top: 20.0),
      height: screenHeight*0.4,
      width: screenWidth*0.6,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/hacker.png'),
          fit: BoxFit.cover,
        ),
      ),
      
      child: new Text('Coming Soon!',
        style: new TextStyle(
          height: 9.0,
          fontFamily: 'Poppins',
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 30.0,
        )
      ),
    ),
   );
    
  }

}