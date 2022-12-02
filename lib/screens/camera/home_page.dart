import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fyp_survilence_system/screens/Notifications/DriverScheduleNotifictaion.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/nav_bar.dart';
import 'package:fyp_survilence_system/screens/camera/detect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/screens/chat/DriverMessageScreen.dart';
import 'package:fyp_survilence_system/screens/payment/home_screen.dart';
import 'package:fyp_survilence_system/screens/payment/login_screen.dart';
import '../admin_dashboard/constants.dart';
import '../admin_dashboard/responsive.dart';
import '../help_and_guide/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'camera_screen.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7, bottom: 5),
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile_pic.png"),
        radius: 30,
        backgroundColor: Colors.white,
      ),
    );
    Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 31,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Admin"),
            ),
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
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

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffAFE1AF),
          flexibleSpace: Padding(
              padding:EdgeInsets.all(10),
              */ /*child:Row(
                  crossAxisAlignment: CrossAxisAlignment.,
                  children: [

                    ProfileCard(),*/ /**/ /*Container(
                            alignment:Alignment.centerRight,
                            child:))*/ /**/ /*
                  ])*/ /*
          ),
          title: const Text("Home Page"),
          leading: ProfileCard(),
          actions: [
          Icon(Icons.more_vert),
      ],
      ),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              },
              child: const Text("Take a Picture"),
            )),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 1,
          brightness: Brightness.dark,
          backgroundColor: Color(0xb00b679b),
          title: Text("${loggedInUser.name}",
              style: MyText.title(context)!.copyWith(
                color: Colors.white,
              )),
          leading: ProfileCard(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, size: 35, color: Colors.white),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingProfileRoute()))
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Positioned(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/justlogo.PNG"),
                  radius: 70,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: <Widget>[
                Container(width: 15),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 12, right: 2),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.camera_enhance,
                                      size: 45, color: Colors.indigo[500]),
                                  onPressed: () async {
                                    /*availableCameras().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => DetectScreen()))),*/
                                    await availableCameras().then((value) =>
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CameraPage(
                                                    cameras: value))));
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Camera",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),
                /*Container(width: 1),*/
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(20.0),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: Icon(Icons.history,
                                    size: 52, color: Colors.indigo[500])),
                            Container(height: 14),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Challan History",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),
                Container(width: 10),
              ],
            ),
            Container(height: 6),
            Row(
              children: <Widget>[
                Container(width: 15),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 12, right: 2),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.schedule_send,
                                      size: 45, color: Colors.indigo[500]),
                                  onPressed: () => {
                                    //
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                DriverScheduleNotification())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text("Schedule",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),
                /*Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 8, right: 20),
                            child: IconButton(
                              icon: Icon(Icons.schedule_send,
                                  size: 45, color: Colors.indigo[500]),
                              onPressed: () => {
                                //
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            DriverScheduleNotification())),
                              },
                            )),
                        Container(height: 10, width: 10),
                        Text("Schedule",
                            style: MyText.body1(context)!
                                .copyWith(color: MyColors.grey_90)),
                      ],
                    ),
                  ),
                ),*/
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 19, right: 2),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.payment,
                                      size: 45, color: Colors.indigo[500]),
                                  onPressed: () => {
                                    //
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginScreenOTP())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Payment",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),

                /*Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 8, right: 35),
                            child: IconButton(
                              icon: Icon(Icons.payment,
                                  size: 45, color: Colors.indigo[500]),
                              onPressed: () => {
                                //
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreenOTP())),
                              },
                            )),
                        Container(height: 10, width: 20),
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 35),
                            child: Text("Payment",
                                style: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_90))),
                      ],
                    ),
                  ),
                ),*/
                Container(width: 15),
              ],
            ),
            Row(
              children: <Widget>[
                Container(width: 15),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 12, right: 2, top: 25),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.chat,
                                      size: 45, color: Colors.indigo[500]),
                                  onPressed: () => {
                                    //
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DriverMessageScreen())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Chat",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),
                /*Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 8, right: 20),
                            child: IconButton(
                              icon: Icon(Icons.chat,
                                  size: 45, color: Colors.indigo[500]),
                              onPressed: () => {
                                //
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DriverMessageScreen())),
                              },
                            )),
                        Container(height: 18),
                        Text("Chat",
                            style: MyText.body1(context)!
                                .copyWith(color: MyColors.grey_90)),
                      ],
                    ),
                  ),
                ),*/
                Container(width: 6),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 12, right: 2, top: 25),
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.notifications,
                                      size: 45, color: Colors.indigo[500]),
                                  onPressed: () => {
                                    //
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DriverMessageScreen())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text("Notifications",
                                    style: MyText.body1(context)!.copyWith(
                                        color: MyColors.grey_90,
                                        fontSize: 13))),
                          ],
                        ),
                      ),
                    )),
                /*Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 35),
                            child: Icon(Icons.notifications,
                                size: 45, color: Colors.indigo[500])),
                        Container(height: 18),
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 35),
                            child: Text("Notifications",
                                style: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_90))),
                      ],
                    ),
                  ),
                ),*/
                Container(width: 15),
              ],
            ),
            Container(height: 6),
          ],
        ),
      ),
    );
  }
}
