import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/screens/Challan/ChallanGeneration_by_officer.dart';
import 'package:fyp_survilence_system/screens/Challan/SearchChallanHistory.dart';
import 'package:fyp_survilence_system/screens/Notifications/NotificationListScreen_forOfficer.dart';
import 'package:fyp_survilence_system/screens/chat/OfficersMessageScreen.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/Officer_settings.dart';
import '../admin_dashboard/constants.dart';
import '../admin_dashboard/responsive.dart';
import '../help_and_guide/settings.dart';

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

class OfficerHomePage extends StatefulWidget {
  const OfficerHomePage({Key? key}) : super(key: key);

  @override
  State<OfficerHomePage> createState() => _OfficerHomePageState();

}
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7, bottom:5),
      child:CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile_pic.png"),
        radius: 30,
        backgroundColor: Colors.white,

      ),
    );Container(
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
class _OfficerHomePageState extends State<OfficerHomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  OfficerModel loggedInUser = OfficerModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {

    super.initState();
    FirebaseFirestore.instance
        .collection("Officer")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = OfficerModel.fromMapOfficer(value.data());
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
              *//*child:Row(
                  crossAxisAlignment: CrossAxisAlignment.,
                  children: [

                    ProfileCard(),*//**//*Container(
                            alignment:Alignment.centerRight,
                            child:))*//**//*
                  ])*//*
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
          elevation: 1, brightness: Brightness.dark,
          backgroundColor: Color(0xb00d4d79),
          title: Text("${loggedInUser.OfficerName}", style: MyText.title(context)!.copyWith(color: Colors.white,)),
          leading: ProfileCard(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, size: 35, color:Colors.white),
              onPressed: () => {Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OfficerSetting()))},
            ),
          ]
      ),
      body: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Positioned(
                child:CircleAvatar(
                  backgroundImage: AssetImage("assets/justlogo.PNG"),
                  radius: 70,
                  backgroundColor: Colors.white,

                ),),),

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
                    margin: EdgeInsets.only(left: 8, right: 2, top: 20),
                child: Expanded(
                  child: Container( padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Padding(
                            padding: EdgeInsets.only(left: 8, right: 20),
                            child: IconButton(
                              icon: Icon(Icons.featured_play_list, size: 45, color:Colors.indigo[500]),
                              onPressed: () =>
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ChallanGenerationByOfficer())),
                                },

                            )),
                        Container(height: 18),
                        Padding(
                            padding: EdgeInsets.only(left: 22, right: 20),
                            child:
                            Text("Challan", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                        Padding(
                            padding: EdgeInsets.only(left: 23, right: 20),
                            child:
                            Text("Generation", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                      ],
                    ),
                  ),
                )),
                Container(width: 1),

                Container(width: 1),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 8, right: 2, top: 20),
                    child: Expanded(
                      child: Container( padding: EdgeInsets.symmetric(vertical: 10, horizontal: 27),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.history, size: 45, color:Colors.indigo[500]),
                                  onPressed: () =>{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ChallanHistory())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 22, right: 20),
                                child:
                                Text("Challan", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                            Padding(
                                padding: EdgeInsets.only(left: 23, right: 20),
                                child:
                                Text("History", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                          ],
                        ),
                      ),
                    )),
                Container(width: 15),
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
                    margin: EdgeInsets.only(left: 8, right: 2, top: 20),
                    child: Expanded(
                      child: Container( padding: EdgeInsets.symmetric(vertical: 16, horizontal: 36),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.chat, size: 45, color:Colors.indigo[500]),
                                  onPressed: () => {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => OfficerMessageScreen())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 22, right: 20),
                                child:
                                Text("Chat", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                          ],
                        ),
                      ),
                    )),
                Container(width: 6),
                Card(
                    elevation: 3,
                    color: Colors.white24,
                    shadowColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 4, right: 2, top: 20),
                    child: Expanded(
                      child: Container( padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                                padding: EdgeInsets.only(left: 8, right: 20),
                                child: IconButton(
                                  icon: Icon(Icons.notifications, size: 45, color:Colors.indigo[500]),
                                  onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AllNotificationsForOfficer())),
                                  },
                                )),
                            Container(height: 18),
                            Padding(
                                padding: EdgeInsets.only(left: 22, right: 20),
                                child:
                                Text("Notifications", style: MyText.body1(context)!.copyWith(color: MyColors.grey_90))),
                          ],
                        ),
                      ),
                    )),
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
