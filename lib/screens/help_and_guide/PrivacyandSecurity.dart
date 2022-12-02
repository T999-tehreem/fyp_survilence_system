import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/settings.dart';
import 'package:fyp_survilence_system/utils/color.dart';

class PrivacyAndSecurityRoute extends StatefulWidget {

  PrivacyAndSecurityRoute();

  @override
  PrivacyAndSecurityRouteState createState() => new PrivacyAndSecurityRouteState();
}


class PrivacyAndSecurityRouteState extends State<PrivacyAndSecurityRoute> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: AppBar(
        backgroundColor: Color(0xb00b679b), brightness: Brightness.dark,
        title: Text("Privacy and Security"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SettingProfileRoute()));},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(backgroundColor: Colors.white, backgroundImage: AssetImage("assets/justlogo.PNG"),radius: 30,),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("APS", style: MyText.title(context)!.copyWith(color: welcome_color)),
                            Container(height: 2),
                            Text("Accident Prevention System", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.info, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Version", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("1.0", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.sync, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Text("Changelog", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60)),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.book, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Text("License", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60)),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Author", style: MyText.subhead(context)!.copyWith(color: welcome_color, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.person, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Bareera Iqbal", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("Pakistan", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.file_download, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Text("Download From Cloud", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Company", style: MyText.subhead(context)!.copyWith(color: welcome_color, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.business, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Comsats University", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("Android App Specialist", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.location_on, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Expanded(
                          child: Text("Comsats University Islamabad, Park Road, Pakistan", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}