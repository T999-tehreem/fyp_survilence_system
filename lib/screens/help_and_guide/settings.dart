import 'dart:async';
import 'dart:typed_data';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/AskaQuestion.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/FAQ.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../utils/color.dart';
import 'PrivacyandSecurity.dart';

class MyColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF1E88E5);
  static const Color accent = Color(0xFFFF4081);
  static const Color accentDark = Color(0xFFF50057);
  static const Color accentLight = Color(0xFFFF80AB);
  static const Color grey_3 = Color(0xFFf7f7f7);
  static const Color grey_5 = Color(0xFFf2f2f2);
  static const Color grey_10 = Color(0xFFe6e6e6);
  static const Color grey_20 = Color(0xFFcccccc);
  static const Color grey_40 = Color(0xFF999999);
  static const Color grey_60 = Color(0xFF666666);
  static const Color grey_80 = Color(0xFF37474F);
  static const Color grey_90 = Color(0xFF263238);
  static const Color grey_95 = Color(0xFF1a1a1a);
  static const Color grey_100_ = Color(0xFF0d0d0d);
}

class MyText {
  static TextStyle? display4(BuildContext context) {
    return Theme.of(context).textTheme.headline1;
  }

  static TextStyle? display3(BuildContext context) {
    return Theme.of(context).textTheme.headline2;
  }

  static TextStyle? display2(BuildContext context) {
    return Theme.of(context).textTheme.headline3;
  }

  static TextStyle? display1(BuildContext context) {
    return Theme.of(context).textTheme.headline4;
  }

  static TextStyle? headline(BuildContext context) {
    return Theme.of(context).textTheme.headline5;
  }

  static TextStyle? title(BuildContext context) {
    return Theme.of(context).textTheme.headline6;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
      fontSize: 18,
    );
  }

  static TextStyle? subhead(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle? body2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1;
  }

  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2;
  }

  static TextStyle? caption(BuildContext context) {
    return Theme.of(context).textTheme.caption;
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.button!.copyWith(letterSpacing: 1);
  }

  static TextStyle? subtitle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2;
  }

  static TextStyle? overline(BuildContext context) {
    return Theme.of(context).textTheme.overline;
  }
}

class SettingProfileRoute extends StatefulWidget {
  SettingProfileRoute();

  @override
  SettingProfileRouteState createState() => new SettingProfileRouteState();
}

class SettingProfileRouteState extends State<SettingProfileRoute> {
  static GlobalKey previewContainer = new GlobalKey();
  bool isSwitched1 = true;

  int timer =60;
  bool canceltimer = false;
  String showtimer = "60";

  String url = "";
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    starttimer();
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMapDriver(value.data());
      setState(() {});
    });
  }
  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      if(mounted) {
        setState(() {
          if (timer < 1) {
            t.cancel();

          } else if (canceltimer == true) {
            t.cancel();
          } else {
            timer = timer - 1;
          }
          showtimer = timer.toString();
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // overriding the setstate function to be called only if mounted
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        backgroundColor: MyColors.grey_10,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 180.0,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xb00b679b),
                flexibleSpace: FlexibleSpaceBar(),
                bottom: PreferredSize(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        alignment: Alignment.bottomRight,
                        constraints: BoxConstraints.expand(height: 50),
                        child: Padding(
                          padding:EdgeInsets.only(right: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(loggedInUser.name.toString(),
                                    style: MyText.headline(context)!
                                        .copyWith(color: Colors.white)),
                                CircleAvatar(
                                  backgroundImage:
                                  AssetImage('assets/images/profile_pic.png'),
                                ),
                              ]),
                        )),
                    preferredSize: Size.fromHeight(50)),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Info",
                                style: MyText.subhead(context)!.copyWith(
                                    color: welcome_color,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(height: 10),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(loggedInUser.phoneno.toString(),
                                    style: MyText.medium(context)
                                        .copyWith(color: MyColors.grey_80)),
                                Text("Phone",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(loggedInUser.driverId.toString(),
                                    style: MyText.medium(context)
                                        .copyWith(color: MyColors.grey_80)),
                                Text("Driver ID",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(loggedInUser.drivingrank.toString(),
                                    style: MyText.medium(context)
                                        .copyWith(color: MyColors.grey_80)),
                                Text("Rank",
                                    style: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Settings",
                                style: MyText.subhead(context)!.copyWith(
                                    color: welcome_color,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(height: 10),

                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap:()=> {Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyAndSecurityRoute() ))},
                        child: Container(
                          width: double.infinity,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Text("Privacy and Security",
                              style: MyText.medium(context)
                                  .copyWith(color: MyColors.grey_80)),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: <Widget>[
                                Text("Language",
                                    style: MyText.medium(context)
                                        .copyWith(color: MyColors.grey_80)),
                                Spacer(),
                                Text("English",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: welcome_color)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Support",
                                style: MyText.subhead(context)!.copyWith(
                                    color: welcome_color,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(height: 10),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () =>  {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AskAQuestion() ))
                        },
                        child: Container(
                          width: double.infinity,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Text("Ask a Question",
                              style: MyText.medium(context)
                                  .copyWith(color: MyColors.grey_80)),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ() ))
                        },
                        child: Container(
                          width: double.infinity,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Text("F A Q",
                              style: MyText.medium(context)
                                  .copyWith(color: MyColors.grey_80)),
                        ),
                      ),
                      Divider(height: 0),
                      InkWell(
                        highlightColor: Colors.grey.withOpacity(0.1),
                        splashColor: Colors.grey.withOpacity(0.1),
                        onTap: () => () {},
                        child: Container(
                          width: double.infinity,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Text("User Manual",
                              style: MyText.medium(context)
                                  .copyWith(color: MyColors.grey_80)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 15),
                Text("Copyright @2022",
                    style: MyText.caption(context)!
                        .copyWith(color: welcome_color)),
                Container(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}