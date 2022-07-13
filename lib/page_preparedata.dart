

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_home.dart';
import 'package:miracle_apps/page_setpin.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class PrepareData extends StatefulWidget{

  @override
  _PrepareData createState() => _PrepareData();
}



class _PrepareData extends State<PrepareData> {



  //=============================================================================
  String getEmail = '...';
  String getPhone = '...';
  String getIdentifier = '...';
  String getPartyID = '...';
  String getMyID = '...';
  _startingVariable() async {
    await AppHelper().getConnect().then((value){if(value == 'ConnInterupted'){
      showToast("Koneksi terputus..", gravity: Toast.CENTER,duration:
      Toast.LENGTH_LONG);}});
    await AppHelper().getSession().then((value){
      setState(() {
        getPhone = value[0];
        getIdentifier = value[1];
        getPartyID = value[2];
        getMyID = value[12];
      });});

  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }


  showFlushBarsuccess(BuildContext context, String stringme) => Flushbar(
    // title:  "Hey Ninja",
    message:  stringme,
    shouldIconPulse: false,
    duration:  Duration(seconds: 5),
    backgroundColor: Colors.black,
    flushbarPosition: FlushbarPosition.BOTTOM ,
  )..show(context);


  void showsuccess(String txtError){
    showFlushBarsuccess(context, txtError);
    return;
  }

  String val_getPhone = "...";
  getData() async {
    Map<String,String> headers = {'Content-Type':'application/json'};
    final msg = jsonEncode({"phone": getPhone, "partyid": getPartyID, "myid":getMyID, "myidentifier":getIdentifier});
    var url = "https://prod-21.southeastasia.logic.azure.com:443/workflows/177680ef759b4236b4dc8ec52fa73677/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=Xiof-qYj-0sJQF4-noYyLi0t5MB8_VvVxpQEj2X26vo";
    var response2 = await http.post(url,
      headers: headers,
      body: msg,
    );
    Navigator.pushReplacement(context, ExitPage(page: Home()));
  }


  loadData() async {
    await _startingVariable();
    await getData();
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child : Visibility(
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitCircle(
                    size: 120,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child:  Container(
                      height: 40,
                      child :
                      AnimatedTextKit(
                        animatedTexts: [
                          RotateAnimatedText('Experience',
                              textStyle: TextStyle(
                                  fontFamily: 'VarelaRound',
                                  letterSpacing: 3,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#44a440"))),
                          RotateAnimatedText('The Miracle',
                              textStyle: TextStyle(
                                  fontFamily: 'VarelaRound',
                                  letterSpacing: 3,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#44a440"))),
                          RotateAnimatedText('Touch',
                              textStyle: TextStyle(
                                fontFamily: 'VarelaRound',
                                  letterSpacing: 3,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#44a440"))),
                        ],
                        isRepeatingAnimation: true,
                        //totalRepeatCount: 10,
                        pause: Duration(milliseconds: 2000),
                      ),
                    )

                  )

                ],
              )
          )
      ),
      bottomSheet: Container(
        color: Colors.white,
        width: double.infinity,
        height: 50,
        child : Center(
          child: AnimatedTextKit(
            totalRepeatCount: 40,
            animatedTexts: [
              FadeAnimatedText(
                'Mohon menunggu sebentar...',
                textStyle: const TextStyle(
                    fontFamily: 'VarelaRound',
                    color: Colors.black,
                    fontSize: 13.0),
                duration: Duration(milliseconds: 8000),
              ),
              FadeAnimatedText(
                'Generate Point...',
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'VarelaRound',
                    fontSize: 13),
                duration: Duration(milliseconds: 8000),
              ),
              FadeAnimatedText(
                'Get existing transaction...',
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'VarelaRound',
                    fontSize: 13),
                duration: Duration(milliseconds: 8000),
              ),




              /*  ScaleAnimatedText(
                'Then Get Bigger',
                duration: Duration(milliseconds: 4000),
                textStyle:
                const TextStyle(color: Colors.indigo, fontSize: 50.0),
              ),*/
            ],
          ),
        ),
      ),
    ), onWillPop: onWillPop);
  }


  Future<bool> onWillPop() {

  }
}
