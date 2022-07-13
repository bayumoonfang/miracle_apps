import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miracle_apps/page_home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:miracle_apps/Helper/app_link.dart';
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';


class PageRedeemPointVerified extends StatefulWidget {
  final String getRedeemCode;
  final String getQty;
  final String getQtyRupiah;
  const PageRedeemPointVerified(this.getRedeemCode,this.getQty,this.getQtyRupiah);
  @override
  _PageRedeemPointVerified createState() => _PageRedeemPointVerified();
}


class _PageRedeemPointVerified extends State<PageRedeemPointVerified> {

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
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
                  QrImage(
                    data: widget.getRedeemCode,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50,left: 25,right: 25),
                    child: Text("Berikan Qr Code ini ke kasir untuk verifikasi proses selanjutnya",textAlign: TextAlign.center,style :
                    GoogleFonts.lato(fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50,left: 25,right: 25),
                    child: Text("Redeem : "+widget.getQty+ " point ("+ "Rp. "+
                        NumberFormat.currency(
                            locale: 'id', decimalDigits: 0, symbol: '').format(
                            int.parse(widget.getQtyRupiah))+")",textAlign: TextAlign.center,style :
                    GoogleFonts.lato(fontSize: 14)),
                  )

                ],
              )
          )
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(right: 25,left:25 ),
        height: 70,
        width: double.infinity,
        child: Container(
            width: double.infinity,
            height: 75,
            padding : const EdgeInsets.only(bottom: 20),
            child :
            RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.white,
                  width: 0.1,
                  style: BorderStyle.solid
              ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child : Text("CLOSE", style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
              onPressed: (){
                Navigator.pushReplacement(context, ExitPage(page: Home()));

              },
            )
        ),
      ),
    ), onWillPop: onWillPop);

  }

  Future<bool> onWillPop() {
  }
}