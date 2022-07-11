
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PageLogin extends StatefulWidget{

  @override
  _PageLogin createState() => _PageLogin();
}



class _PageLogin extends State<PageLogin> {

  @override
  Widget build(BuildContext context) {
      return WillPopScope(child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 25,right: 25),
          child : Align(
            alignment: Alignment.centerLeft,
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.centerLeft,child : Text("Hallo,", style : GoogleFonts.poppins(fontWeight: FontWeight.bold,
                fontSize: 32, color: HexColor("#44a440")))),
                Padding(padding: const EdgeInsets.only(top: 1),child :  Align(alignment: Alignment.centerLeft,
                    child : Text("Nomor Handphone", style : GoogleFonts.poppins(fontWeight: FontWeight.bold,
                        fontSize: 18))),),
                  Opacity(
                    opacity: 0.8,
                    child :    Padding(padding: const EdgeInsets.only(top: 5),child :  Align(alignment: Alignment.centerLeft,
                        child : Text("Pastikan nomor anda sudah terdaftar dan aktif", style : GoogleFonts.lato(
                            fontSize: 13))),)
                  ),

                Padding(padding: const EdgeInsets.only(top: 10,right: 15),
                  child: TextFormField(
                    //controller: _namatoko,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(fontFamily: "VarelaRound",fontSize: 15),
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 1,left: 10,bottom: 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#DDDDDD"), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#DDDDDD"), width: 1.0),
                      ),
                      hintText: '0812345678',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 2), // add padding to adjust icon
                        child: Icon(Icons.phone, size: 20,),
                      ),
                    ),
                  ),
                ),


              ],
            )
          )
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 55,
          padding : const EdgeInsets.only(left: 25,right: 25,bottom: 10),
          child : RaisedButton(
            elevation: 0,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.white,
                  width: 0.1,
                  style: BorderStyle.solid
              ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            child : Text("CONTINUE", style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
            onPressed: (){

            },
          )
        ),
      ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
  }
}