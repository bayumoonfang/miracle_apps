
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:miracle_apps/Helper/app_helper.dart';
import 'package:miracle_apps/Helper/page_route.dart';
import 'package:miracle_apps/page_setpin.dart';
import 'package:miracle_apps/page_verifikasi.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flushbar/flushbar.dart';

import 'Helper/app_link.dart';


class PageLogin extends StatefulWidget{

  @override
  _PageLogin createState() => _PageLogin();
}



class _PageLogin extends State<PageLogin> {
  final _phonenumber = TextEditingController();
  bool isLoading = false;
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


  _login() async {
      if(_phonenumber.text == "") {
        showsuccess("Nomor handphone tidak boleh kosong");
        setState(() {
          isLoading = false;
        });
        return false;
      }


      Map<String,String> headers = {'Content-Type':'application/json'};
      final msg = jsonEncode({"phone": _phonenumber.text});
      var url = "https://prod-22.southeastasia.logic.azure.com:443/workflows/c6be0e70bcd943a29195992f57ce6d5b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=pYd9LBmSJ0wWKVfc679DbcatV4mi9S-qrjCWvCUS2NM";
      var response = await http.post(url,
        headers: headers,
        body: msg,
      );
      Map showdata = jsonDecode(response.body);

      if(showdata["status"] == 300) {
        showsuccess("Mohon maaf anda belum terdaftar sebagai customer MIRACLE, silahkan lakukan pendaftaran di cabang MIRACLE terdekat");
        setState(() {
          isLoading = false;
        });
        return false;

      } else  if(showdata["status"] == 310) {
        showsuccess("Mohon maaf email anda belum terisi, silahkan melakukan penginian data di cabang miracle terdekat");
        setState(() {
          isLoading = false;
        });
        return false;

      } else {

        final response2 = await http.post(applink+"sistem_api.php?act=cekuser_local",
            body: {"phone": _phonenumber.text},
            headers: {"Accept":"application/json"});
        Map data2 = jsonDecode(response2.body);
        if(data2["message"] == '1') {
          await http.post(
              applink+"sistem_api.php?act=sendemail_verifikasi",
              body: {"phone": _phonenumber.text,"email" : showdata["data"]["custemail"].toString(),
                "custnama" : showdata["data"]["custnama"].toString()});
          Navigator.push(context, ExitPage(page: PageVerifikasi(showdata["data"]["custemail"].toString(), _phonenumber.text,
              showdata["data"]["custnama"].toString())));
          _phonenumber.clear();
          setState(() {
            isLoading = false;
          });
        } else if(data2["message"] == '2') {
            Navigator.push(context, ExitPage(page: PageSetPin(_phonenumber.text)));
            _phonenumber.clear();
            setState(() {
              isLoading = false;
            });
        }
      }
      //showsuccess(showdata["data"]["custnama"]);
  }



  _loginact() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isLoading = true;
    });
    await _login();
  }


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
                    controller: _phonenumber,
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
                      hintText: 'Contoh : 0812345678',
                     /* prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 2), // add padding to adjust icon
                        child: Icon(Icons.phone, size: 20,),
                      ),*/
                    ),
                  ),
                ),


              ],
            )
          )
        ),
        bottomSheet:
        isLoading == true ?
        Container(
            width: double.infinity,
            color: Colors.white,
            height: 65,
            padding : const EdgeInsets.only(left: 25,right: 25,bottom: 10),
        child :
        Center(
          child:  SizedBox(
            child: CircularProgressIndicator(),
            height: 30.0,
            width: 30.0,
          ),
        ))
            :
        Container(
          width: double.infinity,
          height: 55,
          padding : const EdgeInsets.only(left: 25,right: 25,bottom: 10),
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
            child : Text("CONTINUE", style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
            onPressed: (){
                   _loginact();
            },
          )
        ),
      ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
  }
}