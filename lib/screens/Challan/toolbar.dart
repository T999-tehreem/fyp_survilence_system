import 'package:flutter/material.dart';
import 'my_toast.dart';

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

class CommonAppBar {
  static Widget getPrimaryAppbar(BuildContext context, String title){
    return AppBar(
      backgroundColor: MyColors.primary, brightness: Brightness.dark,
      titleSpacing: 0,
      title: Text(title,),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {Navigator.pop(context);},
      ),


    );
  }

  static Widget getPrimaryAppbarLight(BuildContext context, String title){
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: MyColors.grey_60),
      titleSpacing: 0,
      title: Text(title, style: MyText.title(context)!.copyWith(
          color: MyColors.grey_60
      )),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {Navigator.pop(context);},
      ),

    );
  }

  static Widget getPrimarySettingAppbar(BuildContext context, String title, { bool light = false }){
    return AppBar(
      backgroundColor: light ?  Color(0xb00d4d79) :  Color(0xb00d4d79),
      brightness: Brightness.dark, titleSpacing: 0,
      iconTheme: IconThemeData(color: light ? MyColors.grey_60 : Colors.white),
      title: Text(title, style: MyText.title(context)!.copyWith(
          color: light ? MyColors.grey_60 : Colors.white
      )),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

    );
  }

  static Widget getPrimaryBackAppbar(BuildContext context, String title){
    return AppBar(
      backgroundColor:  Color(0xb00d4d79),
      title: Text(title,),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

    );
  }



}
