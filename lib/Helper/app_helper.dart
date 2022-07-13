
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:miracle_apps/Helper/app_link.dart';
import 'package:miracle_apps/Helper/session.dart';
import 'dart:async';
import 'dart:convert';

import 'connection_cek.dart';


class AppHelper{
  String getUserPhone ;
  static var today = new DateTime.now();
  var getBulan = new DateFormat.MMMM().format(today);
  var getTahun = new DateFormat.y().format(today);
  var point_value = "1000";


  Future<String> getConnect() async {
    ConnectionCek().check().then((internet){
      if (internet != null && internet) {} else {
        return "ConnInterupted";
      }
    });
  }

  Future<dynamic> getSession () async {
    String getCustPhone = await Session.getCustPhone();
    String getCustIdentifier = await Session.getCustIdentifier();
    String getPartyid = await Session.getPartyid();
    String getCustAddress = await Session.getCustAddress();
    String getCustBirthday = await Session.getCustBirthday();
    String getCustBirthMonth = await Session.getCustBirthMonth();
    String getCustPersonality = await Session.getCustPersonality();
    String getCustCreatedDate = await Session.getCustCreatedDate();
    String getCustStatus = await Session.getCustStatus();
    String getCustModified = await Session.getCustModified();
    String getEmail = await Session.getEmail();
    String getCustName = await Session.getCustName();
    String getCustMyID = await Session.getCustMyID();

    return [
      getCustPhone, //0,
      getCustIdentifier, //1
      getPartyid, //2
      getCustAddress, //3
      getCustBirthday, //4
      getCustBirthMonth, //5
      getCustPersonality, //6
      getCustCreatedDate, //7
      getCustStatus, //8
      getCustModified, //9
      getEmail, //10
      getCustName, //11
      getCustMyID //12
    ];

  }



  Future<dynamic> getDetailUser(String getPhone, String getPartyid) async {
    http.Response response = await http.Client().get(
        Uri.parse(applink+"sistem_api.php?act=another_userdetail&phone="+getPhone.toString()+"&partyid="+getPartyid.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"}).timeout(
        Duration(seconds: 10),onTimeout: (){
      http.Client().close();
      return http.Response('Error',500);
    }
    );
    var data = jsonDecode(response.body);
    return [
      data["point_qty"].toString(), //0
    ];
  }

  Future<dynamic> getSetting() async {
    http.Response response = await http.Client().get(
        Uri.parse(applink+"sistem_api.php?act=get_setting"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"}).timeout(
        Duration(seconds: 10),onTimeout: (){
      http.Client().close();
      return http.Response('Error',500);
    }
    );
    var data = jsonDecode(response.body);
    return [
      data["setting_pointvalue"].toString(), //0
      data["setting_businesscode"].toString(), //1
      data["business_name"].toString(), //2
    ];
  }


}