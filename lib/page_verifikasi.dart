


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_setpin.dart';
import 'dart:async';
import 'dart:convert';
import 'Helper/app_link.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class PageVerifikasi extends StatefulWidget {
  final String getEmail;
  final String getPhone;
  final String getName;


  const PageVerifikasi(this.getEmail,this.getPhone,this.getName);
  @override
  _PageVerifikasi createState() => _PageVerifikasi();
}


class _PageVerifikasi extends State<PageVerifikasi> {
  final _verif1 = TextEditingController();
  final _verif2 = TextEditingController();
  final _verif3 = TextEditingController();
  final _verif4 = TextEditingController();

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

  String acc_identifier = "";
  String acc_partyid = "";
  //String acc_identifier = "";
  String acc_address = "";
  String acc_birthday = "";
  String acc_birthmonth = "";
  String acc_personality = "";

  insertdataCust() async {
    Map<String,String> headers = {'Content-Type':'application/json'};
    final msg = jsonEncode({"phone": widget.getPhone});
    var url = "https://prod-22.southeastasia.logic.azure.com:443/workflows/c6be0e70bcd943a29195992f57ce6d5b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=pYd9LBmSJ0wWKVfc679DbcatV4mi9S-qrjCWvCUS2NM";
    var response2 = await http.post(url,
      headers: headers,
      body: msg,
    );
    Map showdata = jsonDecode(response2.body);
    setState(() {
      acc_identifier = showdata["data"]["custidentifier"].toString();
      acc_partyid = showdata["data"]["custpartyid"].toString();
      acc_address = showdata["data"]["custaddress"].toString();
      acc_birthday = showdata["data"]["custbirthday"].toString();
      acc_birthmonth = showdata["data"]["custbirthmonth"].toString();
      acc_personality = showdata["data"]["custpersonality"].toString();
    });

    await http.post(applink+"sistem_api.php?act=insert_cust",
        body: {
          "phone": widget.getPhone,
          "email": widget.getEmail,
          "name": widget.getName,
          "acc_identifier" : acc_identifier,
          "acc_partyid" : acc_partyid,
          "acc_address" : acc_address,
          "acc_birthday" : acc_birthday,
          "acc_birthmonth" : acc_birthmonth,
          "acc_personality" : acc_personality
        },
        headers: {"Accept":"application/json"});
        Navigator.pushReplacement(context, ExitPage(page: PageSetPin(widget.getPhone)));



    //TINGGAL GET DATA DARI FLOW DAN INSERT KE DATA CUSTOMER LOCAL

  }

  prosesme() async {
      FocusScope.of(context).requestFocus(FocusNode());
      EasyLoading.show(status: "Loading...");
      if(_verif1.text == '' || _verif2.text == '' || _verif3.text == '' || _verif4.text == '' ){
        EasyLoading.dismiss();
        showsuccess("Kode Verifikasi tidak boleh kosong");
        return false;
      }

      final response = await http.post(applink+"sistem_api.php?act=cekverifikasi",
          body: {"phone": widget.getPhone, "email": widget.getEmail, "verifcode" : _verif1.text+_verif2.text+_verif3.text+_verif4.text},
          headers: {"Accept":"application/json"});
      Map data = jsonDecode(response.body);
      setState(() {
        if (data["message"].toString() == '1') {
          //EasyLoading.dismiss();
          insertdataCust();

        } else {
          EasyLoading.dismiss();
          showsuccess("Kode Verifikasi salah");
          return false;
        }
      });

  }

  proses_verifikasi() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await prosesme();
  }




  @override
  Widget build(BuildContext context) {
      return WillPopScope(child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => IconButton(
                icon: new FaIcon(FontAwesomeIcons.angleLeft,color: Colors.black,size: 25,),
                color: Colors.white,
                onPressed: () => {
                  Navigator.pop(context)
                }),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 25,right: 25),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft,
              child : Padding(padding: const EdgeInsets.only(top: 10),child: Text("ENTER VERIFICATION CODE",style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold,
                  fontSize: 20),),)),
              Align(alignment: Alignment.centerLeft,
                  child : Padding(padding: const EdgeInsets.only(top: 3),child: Text("Kode verifikasi telah dikirimkan ke email "+widget.getEmail
                    ,style: GoogleFonts.lato(fontSize: 13),),)),
              Align(alignment: Alignment.centerLeft,
                  child : Padding(padding: const EdgeInsets.only(top: 30),
                    child: Form(
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              autofocus: true,
                              controller: _verif1,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if(value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _verif2,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if(value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _verif3,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if(value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 68,
                            width: 64,
                            child: TextField(
                              controller: _verif4,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.headline6,
                              onChanged: (value) {
                                if(value.length == 1) {
                                  proses_verifikasi();
                                  //FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),

                        ],
                      )
                    )

                    ,))
            ],
          ),


        ),
      ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
    Navigator.pop(context);
  }
}