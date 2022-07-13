
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

class PageRedeemOutstanding extends StatefulWidget {
  final String getMyID;

  const PageRedeemOutstanding(this.getMyID);
  @override
  _PageRedeemOutstanding createState() => _PageRedeemOutstanding();
}


class _PageRedeemOutstanding extends State<PageRedeemOutstanding> {
  List data;


  String filter = "";
  String sortby = '0';
  Future<List> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(applink+"sistem_api.php?act=getdata_redeemoutstanding&myid="+widget.getMyID),
        headers: {"Accept":"application/json"});
    print(applink+"sistem_api.php?act=getdata_redeemoutstanding&myid="+widget.getMyID);
    return json.decode(response.body);

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
        title: Text("Redeem Outstanding", style: TextStyle(
            fontFamily: 'VarelaRound',
            color: Colors.black,fontSize: 16
        ),),
      ),
      body: Container(
        child : Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 10),),
            Expanded(
              child : FutureBuilder(
                future : getData(),
                builder : (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  } else {
                    return snapshot.data == 0 ?
                    Container(
                        height: double.infinity, width : double.infinity,
                        child: new
                        Center(
                            child :
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  "Tidak ada data",
                                  style: new TextStyle(
                                      fontFamily: 'VarelaRound', fontSize: 18),
                                ),
                                new Text(
                                  "Silahkan lakukan input data",
                                  style: new TextStyle(
                                      fontFamily: 'VarelaRound', fontSize: 12),
                                ),
                              ],
                            )))
                        :
                    new ListView.builder(
                        itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                        padding: const EdgeInsets.only(left: 10,right: 15),
                        itemBuilder: (context, i) {
                            return InkWell(
                              child : Card(
                                  child : Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),child :
                                  ListTile(
                                    title: Text(snapshot.data[i]["a"].toString(),style : GoogleFonts.lato(fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                    trailing: Text(snapshot.data[i]["d"].toString()+"-"+snapshot.data[i]["c"].toString()+"-"+snapshot.data[i]["b"].toString()),
                                    subtitle: Column(
                                      children: [
                                        Padding(padding: const EdgeInsets.only(top: 5),
                                            child:Align(alignment: Alignment.centerLeft,
                                              child: Text(snapshot.data[i]["e"].toString()+ " point ("+ "Rp. "+
                                                  NumberFormat.currency(
                                                      locale: 'id', decimalDigits: 0, symbol: '').format(
                                                      int.parse(snapshot.data[i]["f"].toString()))+")", style: GoogleFonts.varelaRound(color: Colors.black,fontSize: 13)),)),
                                        Padding(padding: const EdgeInsets.only(top: 5),
                                          child: Align(alignment: Alignment.centerLeft,
                                            child: Text(snapshot.data[i]["g"].toString(),style: GoogleFonts.lato(color: Colors.black,fontSize: 13)),),)
                                      ],
                                    ),
                                  )
                                  )
                              )
                            );
                        });
                  }
                }
              )

            )
          ],
        )
      ),
    ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
    Navigator.pop(context);
  }
}