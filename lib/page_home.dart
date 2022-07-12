
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:miracle_apps/Helper/app_helper.dart';

class Home extends StatefulWidget{

  @override
  _Home createState() => _Home();
}


class _Home extends State<Home> {


  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }



  @override
  Widget build(BuildContext context) {
      return WillPopScope(child: Scaffold(
        appBar: new AppBar(
          backgroundColor: HexColor("#DDDDDD"),
          automaticallyImplyLeading: false,
          actions: [



            Padding(padding: const EdgeInsets.only(top: 19,right: 25), child :
            InkWell(
              hoverColor: Colors.transparent,
              child : FaIcon(FontAwesomeIcons.cog, size: 20,color: Colors.black,),
              onTap: () {
                //Navigator.push(context, ExitPage(page: SettingHome(getEmail, getLegalCode)));
              },
            )
            ),
          ],
          title:
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child:   Text("Miracle", style: TextStyle(color: Colors.black,
                  fontFamily: 'VarelaRound', fontSize: 24,
                  fontWeight: FontWeight.bold),)
          ),
          elevation: 0,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                height: 120,
                color:  HexColor("#DDDDDD"),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 15),
                            child:  Align(
                              alignment: Alignment.bottomLeft,
                              child:  Text("Halo,", style: TextStyle(color: Colors.black,
                                  fontFamily: 'VarelaRound', fontSize: 12,
                                  fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 5),
                            child:  Align(
                              alignment: Alignment.bottomLeft,
                              child:  Container(
                                  padding: const EdgeInsets.only(top: 2),
                                  height: 33,
                                  width: double.infinity,
                                  child:           Text("Ragil Bayu Respati",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'VarelaRound',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),)
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 28,top: 5),
                            child:  Align(
                                alignment: Alignment.bottomLeft,
                                child:  Opacity(
                                  opacity: 0.7,
                                  child: Text(AppHelper().getBulan+" "+AppHelper().getTahun, style: TextStyle(color: Colors.black,
                                      fontFamily: 'VarelaRound', fontSize: 11,
                                      fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                )
                            )
                        ),
                      ],
                    ),
                  ],
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 95,left: 25,right: 25),
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
                  height: 77,
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
                              width: 75,
                              child :          Column(
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.store,color: Colors.black,size: 14,),
                                      Padding(padding: const EdgeInsets.only(left: 5),child: Text("987233",style: GoogleFonts.lato(fontSize: 14),),)
                                    ],
                                  ),
                                  Align(alignment: Alignment.centerLeft,child : Padding(padding: const EdgeInsets.only(top:8),
                                    child: Text("Point Saya", style: TextStyle(fontFamily: 'VarelaRound',
                                        fontSize: 11,color: Colors.black)
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
                              width: 80,
                              child :          Column(
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.shoppingBag,color: Colors.black,size: 14,),
                                      Padding(padding: const EdgeInsets.only(left: 5),child: Text("123648",style: GoogleFonts.lato(fontSize: 14),),)
                                    ],
                                  ),
                                  Align(alignment: Alignment.centerLeft,child : Padding(padding: const EdgeInsets.only(top:8),
                                    child: Text("Transaksi", style: TextStyle(fontFamily: 'VarelaRound',
                                        fontSize: 11,color: Colors.black)
                                    ),))
                                ],
                              ),
                            )
                        ),


                        Container(
                          width: 1,
                          padding: const EdgeInsets.only(top: 20),
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
                              width: 89,
                              child :          Column(
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.barcode,color: Colors.black,size: 24,),
                                      Padding(padding: const EdgeInsets.only(left: 5),child: Text("Kartuku",style: GoogleFonts.lato(fontSize: 14),),)
                                    ],
                                  ),

                                ],
                              ),
                            )
                        ),




                      ],
                    ),
                  )

              ),),

          Padding(
            padding: const EdgeInsets.only(top: 200,left: 25,right: 25),
            child: Column(
              children: [
                InkWell(
                  child:  Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: HexColor("#e8fcfb"),
                      ),
                      width: double.infinity,
                      height: 70,
                      child: ListTile(
                        title:
                        Text("Kunjungi Miracle terdekat", style: TextStyle(
                            fontFamily: 'VarelaRound',fontWeight: FontWeight.bold,
                            fontSize: 14,color: HexColor("#025f64"))),
                        subtitle:
                        Text("Tingkatkan transaksi dan dapatkan point spesial", style: TextStyle(fontFamily: 'VarelaRound'
                            ,fontSize: 12,color: HexColor("#025f64"))),
                        trailing: FaIcon(FontAwesomeIcons.angleRight,color: HexColor("#025f64")),
                      )
                  ),
                  onTap: () {
                    //Navigator.push(context, ExitPage(page: Subscribe(getEmail.toString(), getLegalCode)));
                  },
                ),

                SizedBox(
                  height: 25,
                ),

        Wrap(
          spacing: 30,
          runSpacing: 30,
          children: [
            InkWell(
              onTap: (){
               // Navigator.push(context, ExitPage(page: JualanHome(getEmail.toString(),getLegalCode.toString(),getLegalId.toString(), getNamaUser.toString())));
              },
              child:Column(
                children: [
                  Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#eef9ff"),
                      ),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.cartArrowDown, color: HexColor("#36bbf6"), size: 24,),
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top:8),
                    child: Text("Reedem", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                ],
              ),
            ),

            InkWell(
              onTap: () {
                //Navigator.push(context, ExitPage(page: ProdukHome()));
              },
              child:Column(
                children: [
                  Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#fff4f0"),
                      ),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.fileSignature, color: HexColor("#ff8556"), size: 24,),
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top:8),
                    child: Text("History", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                ],
              ),
            ),



            InkWell(
              onTap: () {
                //Navigator.push(context, ExitPage(page: ProdukHome()));
              },
              child:Column(
                children: [
                  Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#f3effd"),
                      ),
                      child: Center(
                        child: Image.asset("assets/money-bill-transfer-solid2.png",width: 33),
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top:8),
                    child: Text("Transfer", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                ],
              ),
            ),



            InkWell(
              onTap: () {
                //Navigator.push(context, ExitPage(page: ProdukHome()));
              },
              child:Column(
                children: [
                  Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#f7faff"),
                      ),
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.gifts, color: HexColor("#1c6bea"), size: 24,),
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top:8),
                    child: Text("Gift Voucher", style: TextStyle(fontFamily: 'VarelaRound',fontSize: 12)),)
                ],
              ),
            ),




          ],

        )



              ],
            ),

          )

          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Beranda'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Inbox'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_center),
              title: Text('Bantuan'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Akun'),
            ),
          ],
         // currentIndex: _selectedNavbar,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          //onTap: _changeSelectedNavBar,
        ),

      ), onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
  }
}