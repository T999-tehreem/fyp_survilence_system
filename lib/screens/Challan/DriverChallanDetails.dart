import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class MyStrings {

  static const String lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin"
      "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin";

  static const String middle_lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam efficitur ipsum in placerat molestie.  Fusce quis mauris a enim sollicitudin";

  static const String short_lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

  static const String medium_lorem_ipsum = "Quisque imperdiet nunc at massa dictum volutpat. Etiam id orci ipsum. Integer id ex dignissim";

  static const String long_lorem_ipsum = "Duis tellus metus, elementum a lectus id, aliquet interdum mauris. Nam bibendum efficitur sollicitudin. Proin eleifend libero velit, "
      "nec fringilla dolor finibus quis. nMorbi eu libero pellentesque, rutrum metus quis, blandit est. Fusce bibendum accumsan nisi vulputate feugiat. In fermentum laoreet euismod. Praesent sem nisl, "
      "facilisis eget odio at, rhoncus scelerisque ipsum. Nulla orci dui, dignissim a risus ut, lobortis porttitor velit."
      "\n\nNulla id lectus metus. Maecenas a lorem in odio auctor facilisis non vitae nunc. Sed malesuada volutpat massa. Praesent sit amet lacinia augue, mollis tempor dolor.";

  static const String long_lorem_ipsum_2 = "Vivamus porttitor, erat at aliquam mollis, risus ligula suscipit metus, id semper nisi dui lacinia leo. Praesent at feugiat sem. Vivamus consectetur arcu sit amet metus efficitur dapibus. Sed metus ligula, efficitur quis finibus nec, pellentesque nec nulla. Nunc nec magna iaculis turpis vehicula condimentum id lobortis lectus."
      "\n\nQuisque augue diam, convallis nec mollis in, placerat nec elit. Aliquam non erat tristique, consequat tortor ultricies, sodales erat. Aliquam quis enim eu nulla facilisis sollicitudin eu mollis mauris. Donec ornare urna non libero volutpat tempus. Mauris elementum egestas ex, a laoreet urna. Ut a magna mattis, sodales massa a, blandit justo";

  static const String invoice_address = "Terry M Smith\n(904) 246-1297\n207 Cherry St, Neptune Beach, FL, 32266";

  static const String  very_long_lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dolor risus, aliquet a erat quis, viverra molestie orci. Suspendisse vehicula porta libero. Nam tincidunt nulla ipsum, vel iaculis risus scelerisque sed. Phasellus venenatis, enim vel placerat blandit, leo eros bibendum erat, at auctor mauris diam ac risus. Aenean sit amet congue neque, sit amet condimentum elit. Fusce lacinia massa vel nisl scelerisque, in scelerisque dolor elementum. Vivamus leo enim, congue dictum congue vitae, porttitor id purus. Sed eu ultricies erat. Morbi hendrerit, mi ac volutpat commodo, magna turpis pretium nibh, at fringilla eros lorem quis tellus. Praesent porttitor purus nibh, ac vestibulum massa fringilla vel. Pellentesque dapibus nulla quis luctus dictum. In scelerisque ut ex sed facilisis. Nunc eu finibus nulla, ut hendrerit sem. Suspendisse accumsan risus vel diam fringilla iaculis."
      "\n\nQuisque facilisis finibus aliquam. Sed mattis, dui fringilla ornare finibus, orci odio blandit risus, ut maximus dui odio non leo. Donec laoreet lacus nisi, a mollis velit suscipit ac. Quisque faucibus ut nisl in congue. Nam sagittis consectetur tempus. Suspendisse eget posuere dui. Donec ultricies velit ex, vel cursus odio sollicitudin in. Nullam faucibus auctor ligula, eu rhoncus dui facilisis a. Curabitur vel feugiat est. Quisque congue at enim eleifend ultrices. Proin dapibus risus lorem, nec condimentum nunc consequat vitae. Quisque sapien lorem, vestibulum vitae justo eget, fringilla eleifend nisi."
      "\n\nMauris ultricies augue sit amet est sollicitudin laoreet. Fusce ut congue felis. Fusce dictum tristique elit nec iaculis. Mauris sodales tempus fringilla. Fusce nec nunc tempus, tempor sapien sit amet, ultricies erat. Mauris ultrices ac lorem ultrices facilisis. Nam pharetra, nisi a imperdiet interdum, nunc justo ultricies nisl, a laoreet massa dui vel enim. Pellentesque et magna ac tellus ullamcorper malesuada a ac nisl. Curabitur id est et neque convallis accumsan. Aliquam eleifend varius massa. Curabitur eu finibus tortor."
      "\n\nVivamus aliquam nisl rutrum orci volutpat porta in ornare est. Quisque ligula ipsum, vulputate id aliquam vitae, semper vitae orci. Nam non pulvinar ligula, eget tincidunt ante. Quisque sapien massa, varius tempus pretium id, vehicula at magna. Ut ut ultrices augue. Nam nec ullamcorper tellus, at finibus lectus. Fusce vel iaculis mauris, id porta nulla. Aenean ac mollis sapien. Morbi imperdiet augue tempus nulla luctus, sit amet feugiat purus elementum."
      "\n\nIn sit amet rutrum diam. Vivamus laoreet aliquam ipsum eget pretium. Mauris sagittis non elit quis fermentum. Aenean at diam nec tortor maximus rutrum. Sed nec nulla volutpat quam suscipit varius non at erat. Pellentesque non euismod diam, nec dapibus quam. Aliquam et posuere massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam eu nibh sed diam posuere tincidunt et non felis. Aliquam sodales facilisis tortor, at maximus ante varius quis."
      "\n\nSuspendisse ornare est ac auctor pulvinar. Nam in venenatis risus. In facilisis tristique mollis. Curabitur tempus ipsum eget ipsum pharetra ornare. Quisque imperdiet nunc at massa dictum volutpat. Etiam id orci ipsum. Integer id ex dignissim est blandit sollicitudin non ut felis. Mauris nec mattis lacus. Cras consequat sapien a nisl faucibus, id consequat velit aliquet. Donec tincidunt quam elit, et scelerisque ipsum aliquet ac. Suspendisse lectus enim, auctor non justo et, vehicula consectetur nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fermentum ipsum vitae ligula interdum vulputate. Aenean bibendum molestie pharetra. Praesent aliquam, sapien ac rutrum rhoncus, enim mauris lacinia ligula, vitae fermentum purus lacus nec ex. Donec vel dolor pulvinar, dignissim nunc id, tempus risus."
      "\n\nPhasellus blandit, leo ut semper vulputate, dui est fringilla purus, eu ullamcorper leo quam ut odio. Nunc tincidunt est eros, a dapibus massa hendrerit in. Aenean pellentesque ante eu justo pulvinar, eget sodales diam auctor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent vulputate nunc ut lorem viverra, ac condimentum sem vehicula. Etiam in dui quam. Aenean tincidunt porttitor dignissim. Aenean id est erat. Praesent tempus est ullamcorper tincidunt ultricies. Mauris ac velit lorem. Maecenas quis dui vel neque aliquet mattis aliquet et ante."
      "\n\nVivamus porttitor, erat at aliquam mollis, risus ligula suscipit metus, id semper nisi dui lacinia leo. Praesent at feugiat sem. Vivamus consectetur arcu sit amet metus efficitur dapibus. Sed metus ligula, efficitur quis finibus nec, pellentesque nec nulla. Nunc nec magna iaculis turpis vehicula condimentum id lobortis lectus. Etiam tempus nisi arcu, in condimentum felis vestibulum vitae. Donec fermentum dolor consequat nulla dignissim, non tempus leo viverra. Aenean magna magna, ultricies ut rutrum et, malesuada non nibh. Nam ligula erat, elementum sit amet justo eget, venenatis hendrerit nibh. In ac ipsum nunc. Nullam purus dolor, rhoncus eu justo id, vulputate ultrices nunc. Nam et risus velit. Fusce aliquam blandit urna quis pulvinar. Donec luctus tincidunt ipsum eu condimentum. Etiam porttitor dui in pulvinar vulputate."
      "\n\nQuisque augue diam, convallis nec mollis in, placerat nec elit. Aliquam non erat tristique, consequat tortor ultricies, sodales erat. Aliquam quis enim eu nulla facilisis sollicitudin eu mollis mauris. Donec ornare urna non libero volutpat tempus. Mauris elementum egestas ex, a laoreet urna. Ut a magna mattis, sodales massa a, blandit justo. Nunc placerat ante quis lacus dictum dictum vitae eu nisi. Fusce quis est sodales justo sollicitudin mollis. Suspendisse posuere, augue a ultricies lacinia, tortor tortor faucibus purus, pulvinar suscipit erat orci varius arcu. Phasellus id nisl vitae eros dignissim consectetur. Ut ac ex ac arcu vestibulum sagittis sit amet a massa."
      "\n\nSuspendisse elit libero, placerat vel ipsum vitae, tristique faucibus nulla. Aliquam ac elit porttitor, vestibulum turpis nec, bibendum dui. Vivamus quam orci, consequat in scelerisque id, dignissim vel purus. Proin rhoncus ante eu nisi dictum lacinia. Proin congue tempor nunc, eu semper elit tincidunt ut. Duis vehicula purus at lorem sollicitudin porttitor. Nulla facilisi. Donec non dapibus neque. Donec neque massa, sodales vitae eros nec, lacinia vestibulum neque. Nullam venenatis vitae tortor sed fermentum. Aenean massa enim, placerat eu ligula quis, tincidunt rutrum purus. Ut tincidunt egestas varius.";

  static const String  very_long_lorem_ipsum2 = "Aliquam eu mauris lectus. Pellentesque lacinia ut urna ut gravida. Proin libero sem, auctor in posuere sit amet, porta a nibh. Vivamus maximus nunc eu urna pellentesque vulputate. Phasellus lacinia ut diam id mattis. Ut fermentum, sem non viverra maximus, elit massa varius dolor, ac elementum mi nunc eu orci. Fusce ornare mi sed dapibus tempus. Quisque sollicitudin condimentum ex vitae imperdiet. Mauris et est non nibh gravida suscipit eget id est."
      "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis quis elit sed cursus. In commodo malesuada elit. Curabitur eget tortor ipsum. In consequat sollicitudin rhoncus. Donec interdum felis vitae ipsum mattis congue. Suspendisse eget tellus sit amet nunc egestas ultrices. Sed placerat eu arcu vel ullamcorper. Curabitur a dictum odio. Suspendisse fermentum ex vel ullamcorper scelerisque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam at nisl orci. Nullam ligula purus, pulvinar vel ligula sodales, tincidunt porttitor enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut semper tincidunt scelerisque. Praesent mollis magna ut consequat dictum."
      "\n\nDuis in vestibulum dui, non pulvinar tortor. Maecenas finibus nulla purus, ac consectetur erat finibus vitae. Ut eget convallis dolor. Mauris a leo nunc. Nullam facilisis tincidunt odio eget laoreet. Integer sapien ipsum, fringilla id purus et, cursus convallis dolor. Etiam vel lacinia nibh. Donec sollicitudin fermentum eleifend. Vivamus quis mauris in libero vehicula aliquet sit amet quis odio. Etiam et tincidunt turpis, vel iaculis urna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam et mollis enim."
      "\n\nPraesent interdum lectus suscipit enim dictum, sed laoreet nisl posuere. Curabitur accumsan tellus ac iaculis fermentum. Curabitur a purus nec nibh porta imperdiet. Vivamus dignissim libero ut mauris rhoncus finibus non at urna. Phasellus a varius elit, a blandit est. Cras sodales tincidunt purus sit amet condimentum. Phasellus consectetur sem nec nisi congue, id gravida risus tristique. Curabitur vulputate convallis purus, vel bibendum nunc ultricies at."
      "\n\nInteger condimentum egestas eros mollis facilisis. Praesent vitae diam ac diam efficitur pretium nec vitae dui. Nunc quam est, porttitor ut dapibus non, sodales id nulla. Mauris facilisis malesuada dapibus. Aliquam erat volutpat. Vivamus vitae consequat mauris, nec dictum erat. Aliquam in consectetur est, sit amet varius risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Praesent vulputate dapibus lorem, ut interdum lectus bibendum nec. Suspendisse potenti. Cras elementum cursus nisl, ac pulvinar eros fringilla vitae. Cras ac tortor sagittis diam feugiat tincidunt id at est. Curabitur consequat ante purus. Nunc malesuada scelerisque leo vel efficitur.";


  static const String gdpr_privacy_policy = "By using this App, you agree to the Terms-Conditions "
      "Cookies-Policy and Privacy-Policy and consent to having your personal data, behavior transferred and processed outside EU.";

}

class ChallanDetailsScreen extends StatefulWidget {

  ChallanDetailsScreen({required this.vehicleNo,required this.name, required this.rank, required this.challan_description,required this.challan_no,required this.challan_time,required this.challan_type,required this.fine});
  String? challan_no;
  String? challan_time;
  String? name;
  String rank;
  String? vehicleNo;
  String? challan_type;
  String? challan_description;
  String? fine;
  @override
  ChallanDetailsScreenState createState() => new ChallanDetailsScreenState();
}


class ChallanDetailsScreenState extends State<ChallanDetailsScreen> with TickerProviderStateMixin {

  bool expand1 = false;
  bool expand2 = false;
  late AnimationController controller1, controller2;
  late Animation<double> animation1, animation1View;
  late Animation<double> animation2, animation2View;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);
    controller2 = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);

    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);

    animation2 = Tween(begin: 0.0, end: 180.0).animate(controller2);
    animation2View = CurvedAnimation(parent: controller2, curve: Curves.linear);

    controller1.addListener(() { setState(() {}); });
    controller2.addListener(() { setState(() {}); });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: AppBar(
        backgroundColor: Color(0xb00d4d79),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text('Challan History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
              elevation: 3,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity, height: 60,
                child: Row(
                  children: <Widget>[
                    Container(width: 10),
                    Text("Challan no", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_80)),
                    Spacer(),
                    Text('${widget.challan_no}', style: MyText.title(context)!.copyWith(color: MyColors.accent)),
                    Container(width: 10),
                    IconButton(
                      icon: Icon(Icons.content_copy, color: MyColors.grey_60,),
                      onPressed: (){},
                    )
                  ],
                ),
              ),
            ),
            Card(
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
                            Text("${widget.name}", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                            Container(height: 2),
                            Text("${widget.rank}", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                          ],
                        )
                      ],
                    ),
                    Divider(height: 0),
                    Container(
                      height: 150,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Vehicle no", style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                              Container(height: 30),
                              Text("Time", style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(width: 20),
                          Column(
                            children: <Widget>[
                              Container(height: 5),
                              Container(
                                width : 15, height: 15,
                                decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.accent, width: 2),
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                              ),
                              Expanded(
                                child: Container(width: 2, color: MyColors.accent),
                              ),
                              Container(
                                width : 15, height: 15,
                                decoration: BoxDecoration(
                                    color: MyColors.accent,
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
                                Text("${widget.vehicleNo}"),
                                Container(height: 30),
                                Text("${widget.challan_time}"),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            Card(
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
                        Container(child: Icon(Icons.history_edu_rounded, color: MyColors.primary),
                          padding: EdgeInsets.all(20),
                        ),
                        Text(" ${widget.fine}",maxLines: 2, style: MyText.subhead(context)!.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Transform.rotate(
                          angle: animation1.value * math.pi / 180,
                          child: IconButton(
                            icon: Icon(Icons.expand_more, color: MyColors.grey_60),
                            onPressed: (){togglePanel1();},
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
                            child: Text("${widget.challan_description}",maxLines: 2,),
                          ),
                          Divider(height: 0),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(primary: Colors.transparent),
                                child: Text("HIDE", style: TextStyle(color: Colors.grey[800]),),
                                onPressed: (){togglePanel1();},
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

            Container(height: 10)
          ],
        ),
      ),
    );
  }

  void togglePanel1(){
    if(!expand1){
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  void togglePanel2(){
    if(!expand2){
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

