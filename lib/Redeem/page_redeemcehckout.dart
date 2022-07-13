




import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:miracle_apps/Helper/app_link.dart';
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miracle_apps/Redeem/page_redeemverification.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';

class PageRedeemPointCheckout extends StatefulWidget {
  final String getQty;
  final String getQtyRupiah;
  final String getMyID;
  final String getPartyID;
  final String getCabang;
  final String getBusinessCode;
  final String getBusinessName;

  const PageRedeemPointCheckout(this.getQty,this.getQtyRupiah,this.getMyID,this.getPartyID,this.getCabang,this.getBusinessCode,this.getBusinessName);
  @override
  _PageRedeemPointCheckout createState() => _PageRedeemPointCheckout();
}


class _PageRedeemPointCheckout extends State<PageRedeemPointCheckout> {



  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();

  }


  process_checkout() async {
    EasyLoading.show(status: "Loading...");
    final response = await http.post(applink+"sistem_api.php?act=add_redeem", body: {
      "redeem_qty": widget.getQty,
      "redeem_rupiah": widget.getQtyRupiah,
      "redeem_myid": widget.getMyID,
      "redeem_partyid": widget.getPartyID,
      "redeem_cabang": widget.getCabang,
      "redeem_businesscode": widget.getBusinessCode
    });
    Map data = jsonDecode(response.body);
    Navigator.pushReplacement(context, ExitPage(page: PageRedeemPointVerified(data["message"].toString(), widget.getQty, widget.getQtyRupiah)));

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: new AppBar(
        backgroundColor: HexColor("#DDDDDD"),
        leading: Builder(
          builder: (context) => IconButton(
              icon: new Icon(Icons.arrow_back,size: 20,),
              color: Colors.black,
              onPressed : (){
                //FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              }),
        ),
        title: Text("Checkout Redeem Point", style: TextStyle(
            fontFamily: 'VarelaRound',
            color: Colors.black,fontSize: 16
        ),),
      ),
      body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 20,left: 25),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text("My Redeem",style: TextStyle(
                            color: Colors.black, fontFamily: 'VarelaRound',fontSize: 16,
                            fontWeight: FontWeight.bold)),),


                        Padding(padding: const EdgeInsets.only(top: 20,right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                "Place for Redeem",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontSize: 14),
                              ),
                              Text(widget.getBusinessName+" "+widget.getCabang,
                                  style: TextStyle(
                                      fontFamily: 'VarelaRound',
                                      fontSize: 14)),
                            ],
                          ),),

                        Padding(padding: const EdgeInsets.only(top: 20,right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                "Quantity",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontSize: 14),
                              ),
                              Text(widget.getQty+ " point ("+ "Rp. "+
                                  NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0, symbol: '').format(
                                      int.parse(widget.getQtyRupiah))+")",
                                  style: TextStyle(
                                      fontFamily: 'VarelaRound',
                                      fontSize: 14)),
                            ],
                          ),),

                      ],
                    ),),
                ],
              ),
        ),
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
              child : Text("PROCESS", style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
              onPressed: (){
                process_checkout();
              },
            )
        ),
      ),
    ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
    Navigator.pop(context);
  }
}