
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:miracle_apps/Helper/session.dart';
import 'dart:async';
import 'dart:convert';

import 'connection_cek.dart';


class AppHelper{
  String getUserPhone ;
  static var today = new DateTime.now();
  var getBulan = new DateFormat.MMMM().format(today);
  var getTahun = new DateFormat.y().format(today);


  Future<String> getConnect() async {
    ConnectionCek().check().then((internet){
      if (internet != null && internet) {} else {
        return "ConnInterupted";
      }
    });
  }

  Future<dynamic> getSession () async {
    String getPhone = await Session.getPhone();
    return [getPhone];

  }


}