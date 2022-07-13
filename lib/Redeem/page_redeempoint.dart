

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
import 'package:miracle_apps/Redeem/page_redeemcehckout.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';

class PageRedeemPoint extends StatefulWidget {

  @override
  _PageRedeemPoint createState() => _PageRedeemPoint();
}


class _PageRedeemPoint extends State<PageRedeemPoint> {
  String selectClinic;
  List clinicList = List();
  String point_value = AppHelper().point_value;
  String business_code ;

  var textme;
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
  final valQty = TextEditingController();
  showFlushBarsuccess(BuildContext context, String stringme) => Flushbar(
    // title:  "Hey Ninja",
    message:  stringme,
    shouldIconPulse: false,
    duration:  Duration(seconds: 5),
    backgroundColor: Colors.black,
    flushbarPosition: FlushbarPosition.TOP ,
  )..show(context);


  void showsuccess(String txtError){
    showFlushBarsuccess(context, txtError);
    return;
  }
//=============================================================================
  String getEmail = '...';
  String getPhone = '...';
  String getIdentifier = '...';
  String getPartyID = '...';
  String getMyID = '...';
  String getCustName = '...';
  String getPoint = "0";
  String getPointValue = "0";
  String getBusinessCode = "...";
  String getBusinessName = "...";
  int totalme_awal = 0;
  int total_redeem = 0;
  int total_redeemrupiah = 0;
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
        getCustName = value[11];
      });});
    await AppHelper().getDetailUser(getPhone.toString(), getPartyID.toString()).then((value){
      setState(() {
        getPoint = value[0];
      });
    });

    await AppHelper().getSetting().then((value){
      setState(() {
        getPointValue = value[0];
        getBusinessCode = value[1];
        getBusinessName = value[2];
      });
    });


    EasyLoading.dismiss();

  }


  Future getClinicList() async {
    var response = await http.get(
        Uri.encodeFull(applink+"sistem_api.php?act=getdata_clinic"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        clinicList = jsonData;
      });
    }
    //print(bankUserList);
  }




  _hitungrupiah_awal() async {
        setState(() {
          totalme_awal = int.parse(getPoint.toString()) * int.parse(point_value);
        });


  }

  loadData() async {
    await _startingVariable();
    await _hitungrupiah_awal();
    await getClinicList();
  }


  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Loading...");
    loadData();
  }


  checkoutact() async {
    FocusScope.of(context).requestFocus(FocusNode());
    EasyLoading.show(status: "Loading...");
    if(selectClinic == "" || selectClinic == null) {
      showsuccess("Place redeem empty");
      EasyLoading.dismiss();
      return false;
    }

    if(total_redeem.toString() == "0" || total_redeemrupiah.toString() == "0") {
      showsuccess("No Quantity for Redeem");
      EasyLoading.dismiss();
      return false;
    }

    Navigator.push(context, ExitPage(page: PageRedeemPointCheckout(total_redeem.toString(),
        total_redeemrupiah.toString(),getMyID,getPartyID,selectClinic,getBusinessCode,getBusinessName
    )));

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
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pop(context);
              }),
        ),
        title: Text("Redeem Point", style: TextStyle(
            fontFamily: 'VarelaRound',
            color: Colors.black,fontSize: 16
        ),),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: 60,
              color:  HexColor("#DDDDDD"),
              child: Stack(
                children: [
                  Column(
                    children: [

                    ],
                  ),
                ],
              )
          ),

          Padding(
            padding: const EdgeInsets.only(top: 25,left: 25,right: 25),
            child:
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 89,
                width: double.infinity,
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 15,right: 25),
                  child:
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    children: [
                      InkWell(
                          onTap: () {
                            //Navigator.push(context, ExitPage(page: Profile(getEmail.toString(), getUserID.toString())));
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.only(left: 5,top: 5),
                            width: 155,
                            child :          Column(
                              children: [
                                Row(
                                  children: [
                                    Opacity(
                                      opacity : 0.7,
                                      child : Text("Pointku",style: GoogleFonts.varelaRound(fontSize: 15),)
                                    )
                                  ],
                                ),
                                Align(alignment: Alignment.centerLeft,child : Padding(padding: const EdgeInsets.only(top:4),
                                  child: Text(getPoint, style: TextStyle(fontFamily: 'VarelaRound',
                                      fontSize: 28,color: Colors.black)
                                  ),))
                              ],
                            ),
                          )
                      ),


                      Container(
                        width: 1,
                        padding: const EdgeInsets.only(top: 10),
                        height: 30,
                        color: HexColor("#DDDDDD"),
                      ),
                      InkWell(
                          onTap: () {
                            //Navigator.push(context, ExitPage(page: Profile(getEmail.toString(), getUserID.toString())));
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.only(left: 12,top: 5),
                            width: 120,
                            child :          Column(
                              children: [
                                Row(
                                  children: [

                                    Padding(padding: const EdgeInsets.only(left: 1),
                                      child: Text( "Rp. "+
                                          NumberFormat.currency(
                                              locale: 'id', decimalDigits: 0, symbol: '').format(
                                            totalme_awal),style: GoogleFonts.lato(fontSize: 14),),)
                                  ],
                                ),
                                Align(alignment: Alignment.centerLeft,child : Padding(padding: const EdgeInsets.only(top:8),
                                  child: Text("Dalam Rupiah", style: TextStyle(fontFamily: 'VarelaRound',
                                      fontSize: 11,color: Colors.black)
                                  ),))
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                )

            ),),

          Padding(
            padding: const EdgeInsets.only(top: 150,left: 30,right: 25),
            child: Column(
              children: [
               Align(alignment: Alignment.centerLeft,
               child:  Text("Redeem Information", style: TextStyle(
                   fontFamily: 'VarelaRound',fontWeight: FontWeight.bold,
                   fontSize: 14,color: HexColor("#000000"))),),

                Padding(padding: const EdgeInsets.only(top: 30,right: 15,bottom: 17),
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
                  DropdownButton(
                          isExpanded: false,
                          hint: Text("Pilih Cabang",style: TextStyle(
                              fontFamily: "VarelaRound", fontSize: 14
                          )),
                          value: selectClinic,
                          items: clinicList.map((myitem){
                            return DropdownMenuItem(
                                value: myitem['cabang_name'],
                                child: Text(myitem['cabang_name'],style: GoogleFonts.nunito(fontSize: 13))
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              selectClinic = value;
                            });
                          },
                        ),
                    ],
                  ),),



                Padding(padding: const EdgeInsets.only(right: 15,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        "Quantity Point",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'VarelaRound',
                            fontSize: 14),
                      ),
                           Container(
                           child :
                                   SizedBox(
                                     height: 40,
                                     width: 120,
                                     child:  TextField(
                                       controller: valQty,
                                       keyboardType: TextInputType.number,
                                       textAlign: TextAlign.right,
                                       onChanged: (value) {
                                         setState(() {

                                            if(value.isNotEmpty) {
                                              if(int.parse(value) > int.parse(getPoint)) {
                                                showsuccess("Nominal tidak bisa melebihi point anda");
                                                //value = "0";
                                                valQty.clear();
                                                total_redeem = 0;
                                                total_redeemrupiah = 0;
                                                return false;
                                              } else {
                                                total_redeem = int.parse(value);
                                                total_redeemrupiah = int.parse(value) *  int.parse(point_value);
                                              }

                                            } else {
                                              total_redeem = 0;
                                              total_redeemrupiah = 0;
                                              FocusScope.of(context).requestFocus(FocusNode());
                                            }
                                            //valQty.text = value;
                                            //total_redeem = int.parse(value);
                                            //total_redeemrupiah = int.parse(value) * 1000;
                                            //print(textme);

                                         });
                                       },
                                       style: TextStyle(fontFamily: "VarelaRound",fontSize: 20),
                                       decoration: InputDecoration(
                                           hintText: '0',
                                           contentPadding: EdgeInsets.all(10.0),
                                           //labelText: 'Enter something',
                                           enabledBorder: OutlineInputBorder(
                                             borderSide: const BorderSide(width: 1, color: Colors.black),
                                             borderRadius: BorderRadius.circular(5),
                                           ),
                                           focusedBorder: OutlineInputBorder(
                                             borderSide: const BorderSide(width: 1, color: Colors.black),
                                             borderRadius: BorderRadius.circular(5),
                                           )),

                                     ),
                                   ),
                           )
                    ],
                  ),),


                Divider(
                  height: 5,
                ),



              ],
            ),

          )



        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(right: 25),
        height: 150,
        width: double.infinity,
        child: Column(
          children: [
         Align(alignment: Alignment.centerRight,child :
         Row(
           crossAxisAlignment: CrossAxisAlignment.end,
           mainAxisAlignment: MainAxisAlignment.end,
           verticalDirection: VerticalDirection.up,
          // mainAxisSize: MainAxisSize.max,
           children: [
             Padding(padding: const EdgeInsets.only(right: 15,top: 10),child: Opacity(
               opacity: 0.7,
               child:  Text("Total : ",style : GoogleFonts.lato(fontSize: 20)),
             ),),
             Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Padding(padding: const EdgeInsets.only(right: 1),child: Text(total_redeem.toString(),style : GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.bold)),),
                 Padding(padding: const EdgeInsets.only(right: 1),child: Text("Dalam Rupiah ("+
                     "Rp. "+
                     NumberFormat.currency(
                         locale: 'id', decimalDigits: 0, symbol: '').format(
                         total_redeemrupiah)+")",style : GoogleFonts.lato()),),
               ],
             )
           ],
         )),

            Container(
                width: double.infinity,
                height: 75,
                padding : const EdgeInsets.only(left: 25,top: 20),
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
                  child : Text("CHECKOUT", style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
                  onPressed: (){
                    checkoutact();
                  },
                )
            ),
          ],
        ),
      ),
    ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
  }
}