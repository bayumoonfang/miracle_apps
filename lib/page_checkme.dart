import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_home.dart';
import 'package:miracle_apps/page_login.dart';
import 'package:toast/toast.dart';


class PageCheck extends StatefulWidget{

  @override
  _PageCheck createState() => _PageCheck();
}



class _PageCheck extends State<PageCheck> {

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }


  String val_getPhone = "...";
  _startingVariable() async {
    await AppHelper().getConnect().then((value){if(value == 'ConnInterupted'){
      showToast("Koneksi terputus..", gravity: Toast.CENTER,duration:
      Toast.LENGTH_LONG);}});
    await AppHelper().getSession().then((value){
      setState(() {
        if(value[0] == null) {
          Navigator.pushReplacement(context, ExitPage(page: PageLogin()));
        } else {
          Navigator.pushReplacement(context, ExitPage(page: Home()));
        }
      });});
  }


  loadData() async {
    await _startingVariable();
  }

  @override
  void initState() {
    super.initState();
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
             SizedBox(
               child: CircularProgressIndicator(),
               height: 60.0,
               width: 60.0,
             ),
             Padding(
               padding: const EdgeInsets.only(top: 50),
               child: Text("Menyiapkan Data..."),
             )

           ],
         )
       )
     ),
   ), onWillPop: onWillPop);
  }


  Future<bool> onWillPop() {

  }
}