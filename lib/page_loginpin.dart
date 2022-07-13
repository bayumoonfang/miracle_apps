


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_login.dart';
import 'package:miracle_apps/page_preparedata.dart';
import 'dart:async';
import 'dart:convert';
import 'Helper/app_link.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page_home.dart';

class LoginPin extends StatefulWidget {
  //final String getEmail;
  final String getPhone;
  //final String getName;


  const LoginPin(this.getPhone);
  @override
  _LoginPin createState() => _LoginPin();
}


class _LoginPin extends State<LoginPin> {
  final _verif1 = TextEditingController();
  final _verif2 = TextEditingController();
  final _verif3 = TextEditingController();
  final _verif4 = TextEditingController();
  final _verif5 = TextEditingController();
  final _verif6 = TextEditingController();


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
  String acc_address = "";
  String acc_birthday = "";
  String acc_birthmonth = "";
  String acc_personality = "";
  String acc_createddate = "";
  String acc_status = "";
  String acc_modified = "";
  String acc_email = "";
  String acc_name = "";
  String acc_myID = "";
  proses_session() async {
    final response = await http.post(applink+"sistem_api.php?act=getdata_cust",
        body: {"phone": widget.getPhone},
        headers: {"Accept":"application/json"});
    Map data = jsonDecode(response.body);
    setState(() {
      acc_identifier = data["acc_identifier"].toString();
      acc_partyid = data["acc_partyid"].toString();
      acc_address = data["acc_address"].toString();
      acc_birthday = data["acc_birthday"].toString();
      acc_birthmonth = data["acc_birthmonth"].toString();
      acc_personality = data["acc_personality"].toString();
      acc_createddate = data["acc_createddate"].toString();
      acc_status = data["acc_status"].toString();
      acc_modified = data["acc_modified"].toString();
      acc_email = data["acc_email"].toString();
      acc_name = data["acc_name"].toString();
      acc_myID = data["acc_myid"].toString();
    });

    savePref(acc_email, acc_identifier, acc_partyid, acc_name, widget.getPhone, acc_address, acc_birthday,
        acc_birthmonth, acc_personality, acc_createddate, acc_status, acc_modified, acc_identifier, acc_myID);

    if(data["message"] == '1') {
      Navigator.pushReplacement(context, ExitPage(page: Home()));
    } else {
      Navigator.pushReplacement(context, ExitPage(page: PrepareData()));
    }

    //TINGGAL GET DATA DARI FLOW DAN INSERT KE DATA CUSTOMER LOCAL

  }

  prosesme() async {
    FocusScope.of(context).requestFocus(FocusNode());
    EasyLoading.show(status: "Loading...");
    if(_verif1.text == '' || _verif2.text == '' || _verif3.text == '' || _verif4.text == '' ){
      EasyLoading.dismiss();
      showsuccess("PIN tidak boleh kosong");
      return false;
    }

    final response = await http.post(applink+"sistem_api.php?act=cek_pin",
        body: {"phone": widget.getPhone, "pincode" : _verif1.text+_verif2.text+_verif3.text+_verif4.text+_verif5.text+_verif6.text},
        headers: {"Accept":"application/json"});
    Map data = jsonDecode(response.body);
    setState(() {
      if (data["message"].toString() == '1') {
        //EasyLoading.dismiss();
        proses_session();
      } else {
        EasyLoading.dismiss();
        showsuccess("Mohon maaf PIN salah");
        return false;
      }
    });

  }



  savePref(String valEmail,
      String validentifier,
      String val_partyid,
      String val_name,
      String val_phone,
      String val_address,
      String val_birthday,
      String val_birthmonth,
      String val_personality,
      String val_createddate,
      String val_status,
      String val_modified,
      String val_identifier,
      String val_myid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      //preferences.setInt("value", value);
      preferences.setString("email", valEmail);
      preferences.setString("partyid", val_partyid);
      preferences.setString("cust_name", val_name);
      preferences.setString("cust_phone", val_phone);
      preferences.setString("cust_address", val_address);
      preferences.setString("cust_birthday", val_birthday);
      preferences.setString("cust_birthmonth", val_birthmonth);
      preferences.setString("cust_personality", val_personality);
      preferences.setString("cust_createddate", val_createddate);
      preferences.setString("cust_status", val_status);
      preferences.setString("cust_modified", val_modified);
      preferences.setString("cust_identifier", val_identifier);
      preferences.setString("cust_myid", val_myid);
      preferences.commit();
    });


  }


  proses_login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await prosesme();
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
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
            Align(alignment: Alignment.center,
                child : Padding(padding: const EdgeInsets.only(top: 50),child: Text("Login With Your PIN",style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold,
                    fontSize: 20),),)),
            Align(alignment: Alignment.center,
                child : Padding(padding: const EdgeInsets.only(top: 3),child: Text("Masukan 6 digit PIN untuk masuk ke akun anda"
                  ,style: GoogleFonts.lato(fontSize: 13),),)),
            Center(
                child : Padding(padding: const EdgeInsets.only(top: 50),
                  child: Form(
                      child : Wrap(
                        alignment: WrapAlignment.center,

                        spacing: 30,
                        children: [
                          SizedBox(
                            height: 28,
                            width: 24,
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
                            height: 28,
                            width: 24,
                            child: TextField(
                              controller: _verif2,
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
                            height: 28,
                            width: 24,
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
                            height: 28,
                            width: 24,
                            child: TextField(
                              controller: _verif4,
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
                            height: 28,
                            width: 24,
                            child: TextField(
                              controller: _verif5,
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
                            height: 28,
                            width: 24,
                            child: TextField(
                              controller: _verif6,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.headline6,
                              onChanged: (value) {
                                if(value.length == 1) {
                                  proses_login();
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
    Navigator.pushReplacement(context, ExitPage(page: PageLogin()));

  }
}