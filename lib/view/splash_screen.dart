import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/utils/routes/routes_name.dart';
import 'package:newsapp/view/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, RoutesName.login);
    },);
  }
  @override
  Widget build(BuildContext context) {
    double HeightX=MediaQuery.of(context).size.height;
    double WidthY=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              height: HeightX*0.6,
              width: WidthY*0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: AssetImage("images/splash_pic.jpg"),fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: HeightX*0.1,),
          Text("News App",style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold)),
          SizedBox(height: HeightX*0.05,),
          SpinKitWave(size: WidthY*0.1,itemBuilder: (context, index) {
            return DecoratedBox(decoration: BoxDecoration(
              color: Color.fromRGBO(0, 95, 255, 1),
            ));
          },),
        ],
      ),
    );
  }
}
