import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miracle_apps/page_checkme.dart';
import 'Helper/page_route.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  startSplash() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration,(){
      Navigator.pushReplacement(context, ExitPage(page: PageCheck()));
    });
  }
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png",width: 200,height: 100,),
                //Text("Preparing Data...", style : GoogleFonts.varelaRound() )
              ],
            )
        )
    ), onWillPop: onWillPop);
  }



  Future<bool> onWillPop() {
  }
}