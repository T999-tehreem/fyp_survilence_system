import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/challan_model.dart';
import 'package:fyp_survilence_system/screens/Challan/my_strings.dart';
import 'package:fyp_survilence_system/screens/Challan/toolbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fyp_survilence_system/screens/payment/login_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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

class ChallanScreen extends StatefulWidget {
  ChallanScreen(
      {required this.driverName,
      required this.driverRank,
      required this.challantype,
      required this.randomNum,
      required this.ChallanDetails,
      required this.ChallanFine});
  String? challantype;
  String? ChallanDetails;
  int? ChallanFine;
  String? driverName;
  String? driverRank;
  int? randomNum;
  @override
  ChallanScreenState createState() => new ChallanScreenState();
}

class ChallanScreenState extends State<ChallanScreen>
    with TickerProviderStateMixin {
  bool expand1 = false;
  bool expand2 = false;
  late AnimationController controller1, controller2;
  late Animation<double> animation1, animation1View;
  late Animation<double> animation2, animation2View;
  Random rnd = new Random();
  int r = 0;
  final _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMapDriver(value.data());
      setState(() {
        loggedInUser = DriverModel.fromMapDriver(value.data());
      });
    });
    r = 100000 + rnd.nextInt(99999999 - 100000);
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);

    animation2 = Tween(begin: 0.0, end: 180.0).animate(controller2);
    animation2View = CurvedAnimation(parent: controller2, curve: Curves.linear);

    controller1.addListener(() {
      setState(() {});
    });
    controller2.addListener(() {
      setState(() {});
    });
  }

  final Stream<QuerySnapshot<Map<String, dynamic>>> VehicleNumber =
      FirebaseFirestore.instance.collection('routes').snapshots();
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String date_time = DateFormat('EEE d MMM y').format(now);
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: CommonAppBar.getPrimarySettingAppbar(context, "Challan Details")
          as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                height: 60,
                child: Row(
                  children: <Widget>[
                    Container(width: 10),
                    Text("Challan Number",
                        style: MyText.subhead(context)!
                            .copyWith(color: MyColors.grey_80)),
                    Spacer(),
                    Text('${widget.randomNum}',
                        style: MyText.title(context)!
                            .copyWith(color: MyColors.accent)),
                    Container(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.content_copy,
                        color: MyColors.grey_60,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${widget.driverName.toString()}',
                      style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_90,
                          fontWeight: FontWeight.bold)),
                  Container(height: 2),
                  Text('Rank: ${widget.driverRank.toString()}',
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_40)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Driver Id: ${loggedInUser.driverId}",
                      style: MyText.body2(context)!.copyWith(
                          color: MyColors.grey_90,
                          fontWeight: FontWeight.bold)),
                  Container(height: 25),
                  Text("Time: ${formattedDate.toString()}",
                      style: MyText.body2(context)!.copyWith(
                          color: MyColors.grey_90,
                          fontWeight: FontWeight.bold)),
                  Container(height: 25),
                ],
              ),
            ),

            /*Card(

                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
                        elevation: 3,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(child: Icon(Icons.person, color: MyColors.primary),
                                    padding: EdgeInsets.all(20),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(widget.driverName.toString(), style: MyText.subhead(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                                      Container(height: 2),
                                      Text(widget.driverRank.toString(), style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                                    ],
                                  )
                                ],
                              ),
                              Divider(height: 0),
                              Container(

                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Driver Id", style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                                        Container(height: 25),
                                        Text("Time", style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                                        Container(height: 25),
                                        ],
                                    ),
                                    Container(width: 20),
                                    Column(
                                      children: <Widget>[
                                        Container(height: 5),
                                        Container(
                                          width : 15, height: 15,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: MyColors.primary, width: 2),
                                              color: MyColors.primary,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(width: 2, color: MyColors.primary),
                                        ),
                                        Container(
                                          width : 15, height: 15,
                                          decoration: BoxDecoration(
                                              color: MyColors.primary,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        Container(height: 5),
                                      ],
                                    ),
                                    Container(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(loggedInUser.driverId.toString(), style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                                          Container(height: 25),
                                          Text(formattedDate.toString(), style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),*/
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Icon(Icons.history_edu_rounded,
                              color: MyColors.primary),
                          padding: EdgeInsets.all(20),
                        ),
                        Text(widget.challantype.toString(),
                            style: MyText.subhead(context)!.copyWith(
                                color: MyColors.grey_90,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 5),
                        Text('pkr:${widget.ChallanFine.toString()}',
                            style: MyText.subhead(context)!.copyWith(
                                color: MyColors.grey_90,
                                fontWeight: FontWeight.bold)),
                        Transform.rotate(
                          angle: animation1.value * math.pi / 180,
                          child: IconButton(
                            icon: Icon(Icons.expand_more,
                                color: MyColors.grey_60),
                            onPressed: () {
                              togglePanel1();
                            },
                          ),
                        ),
                        Container(width: 10)
                      ],
                    ),
                    SizeTransition(
                      sizeFactor: animation1View,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                            child: Text(widget.ChallanDetails.toString(),
                                style: MyText.subhead(context)!
                                    .copyWith(color: MyColors.grey_80)),
                          ),
                          Divider(height: 0),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.transparent),
                                child: Text(
                                  "HIDE",
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                onPressed: () {
                                  togglePanel1();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 50),
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreenOTP()));
                    },
                    height: MediaQuery.of(context).size.height * 0.05,
                    minWidth: MediaQuery.of(context).size.width * 0.65,
                    color: Color(0xff152e57),
                    child: const Text(
                      'Payment',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void togglePanel1() {
    if (!expand1) {
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  void togglePanel2() {
    if (!expand2) {
      controller2.forward();
    } else {
      controller2.reverse();
    }
    expand2 = !expand2;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
