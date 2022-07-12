


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_loginpin.dart';
import 'package:miracle_apps/page_verifikasi.dart';
import 'dart:async';
import 'dart:convert';
import 'Helper/app_link.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class PageSetPin extends StatefulWidget {
  //final String getEmail;
  final String getPhone;
  //final String getName;


  const PageSetPin(this.getPhone);
  @override
  _PageSetPin createState() => _PageSetPin();
}


class _PageSetPin extends State<PageSetPin> {
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

  prosesme() async {
    FocusScope.of(context).requestFocus(FocusNode());
    EasyLoading.show(status: "Loading...");
    if(_verif1.text == '' || _verif2.text == '' || _verif3.text == '' || _verif4.text == '' || _verif5.text == '' || _verif6.text == '' ){
      EasyLoading.dismiss();
      showsuccess("PIN tidak boleh kosong");
      return false;
    }

    await http.post(applink+"sistem_api.php?act=update_pin",
        body: {"phone": widget.getPhone, "pincode" : _verif1.text+_verif2.text+_verif3.text+_verif4.text+_verif5.text+_verif6.text},
        headers: {"Accept":"application/json"});
        Navigator.pushReplacement(context, ExitPage(page: LoginPin(widget.getPhone)));

  }

  proses_verifikasi() async {
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
                child : Padding(padding: const EdgeInsets.only(top: 50),child: Text("Create Your PIN",style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold,
                    fontSize: 20),),)),
            Align(alignment: Alignment.center,
                child : Padding(padding: const EdgeInsets.only(top: 3),child: Text("Buat 6 digit PIN untuk keamanan akun anda"
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
    //Navigator.pop(context);
  }
}