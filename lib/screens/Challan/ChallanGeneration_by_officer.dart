import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/model/notification_model.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:fyp_survilence_system/model/storage_model.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/controllers/MenuController.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/allDriversInfo.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/dashboard_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../model/challan_model.dart';

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

class ChallanGenerationByOfficer extends StatefulWidget {
  const ChallanGenerationByOfficer({Key? key}) : super(key: key);

  @override
  State<ChallanGenerationByOfficer> createState() =>
      ChallanGenerationByOfficerState();
}

class ChallanGenerationByOfficerState
    extends State<ChallanGenerationByOfficer> {
  var dID, vehicleNo,driverName;

  TextEditingController Name = TextEditingController();
  TextEditingController Vehicle = TextEditingController();
  TextEditingController driverRank = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? mtoken = " ";
  String? driverId;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging. instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted Permission');

    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User Granted Provincial Permission');

    } else {
      print('User declined or has not accepted permission');
    }
  }
  void getID(String id) async
  {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {

            driverId = id.toString();
          });

        }
    );
  }
  void getToken(String id) async
  {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            mtoken = token;
            print("My token is $mtoken");
            driverId = id.toString();
          });
          saveToken(token!,id);
        }
    );
  }

  void saveToken(String token,String id) async{
    await FirebaseFirestore.instance.collection('driver').doc(id).update({
      'token' : token,
    });
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAKuWuS7E:APA91bGZO5T9emMTimo_HiD0KTzadgUddJeaX8egJPWEnAbA-5pkPDtUPRfnlvaeSs8yjxJqfohRTX26rF1i5jpCLVPQ8AFyjly-JQAjQAkeWM44YC29kFJJzdoKwJlvYF_RLMnygSLP',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body' : body,
              'title': title,
            },

            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch(e){
      if (kDebugMode){
        print("error push notification");
      }
    }
  }
  // firebase
  final _auth = FirebaseAuth.instance;
  Random rnd = new Random();
  int r = 0;
  Stream<QuerySnapshot<Map<String, dynamic>>> foundOfficers =
  FirebaseFirestore.instance.collection('driver').snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  OfficerModel loggedInUser = OfficerModel();
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Officer")
        .doc(user!.uid)
        .get()
        .then((value) {

      setState(() {
        loggedInUser = OfficerModel.fromMapOfficer(value.data());
      });
    });
    requestPermission();
    loadFCM();
    listenFCM();
    r = 100000 + rnd.nextInt(99999999 - 100000);
  }

  String dropdownvalue = 'Premium';
  var items = [
    'Premium',
    'Gold',
    'Silver',
  ];
  String dropdownvalue1 = 'Seatbelt violation';
  var items1 = [
    'Seatbelt violation',
    'drowsy state',
    'Seatbelt violation and drowsy state',
  ];
  String dropdownvalue2 = 'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for seatbelt violation and is being fined for driving the vehicle in drowsy state. The concerned person needs to pay the fine amount within the deadline strictly.';
  var items2 = [
    'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for seatbelt violation and is being fined for driving the vehicle in drowsy state. The concerned person needs to pay the fine amount within the deadline strictly.',
    'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for driving the vehicle in drowsy state. The concerned person needs to pay the fine amount within the deadline strictly.',
    'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for seatbelt violation. The concerned person needs to pay the fine amount within the deadline strictly.',
  ];
  String dropdownvalue3 = 'Pkr 300';
  var items3 = [
    'Pkr 300',
    'Pkr 700',
    'Pkr 1000',
  ];
  final Stream<QuerySnapshot<Map<String, dynamic>>> allDrivers =
      FirebaseFirestore.instance.collection('driver').snapshots();
  final Stream<QuerySnapshot<Map<String, dynamic>>> allRoutes =
      FirebaseFirestore.instance.collection('routes').snapshots();
  DateTime selectedDate = DateTime.now();
  Stream<QuerySnapshot<Map<String, dynamic>>> challanInfo =
  FirebaseFirestore.instance.collection('challan').snapshots();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    String date_time = DateFormat('EEE d MMM y').format(now);
    postDetailsToFirestore() async {

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      ChallanModel challanModel= ChallanModel();
      challanModel.Challan_no = r.toString();
      challanModel.challan_driver_name = driverName;
      challanModel.challan_driver_rank = dropdownvalue;
      challanModel.challan_type = dropdownvalue1;
      challanModel.challan_vehicle_no =  vehicleNo;
      challanModel.challan_time = formattedDate.toString();
      challanModel.challan_day = date_time.split(" ")[0];
      challanModel.challan_date = date_time.split(" ")[1];
      challanModel.challan_month = date_time.split(" ")[2];
      challanModel.challan_year = date_time.split(" ")[3];
      challanModel.challan_description = dropdownvalue2;
      challanModel.challan_fine = dropdownvalue3;
      await firebaseFirestore
          .collection("challan")
          .doc()
          .set(challanModel.toMapChallan());
      Fluttertoast.showToast(msg: "Challan Generated successfully :) ");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ));
    }
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text('Generate Challan'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 15),
            Text(
              '* Please fill the required information',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'to generate challan',
              style: TextStyle(fontSize: 16),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
              elevation: 10,
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
                    Text(r.toString(),
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
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
              elevation: 10,
              child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 5),
                  //width: double.infinity, height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                        child: Text(
                          'Driver Name:',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: Expanded(
                          child: StreamBuilder(
                            stream: allDrivers,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (!streamSnapshot.hasData)
                                return Center(child: Text("Loading....."));
                              else {
                                List<DropdownMenuItem<String>> currencyItems =
                                    [];
                                for (int i = 0;
                                    i < streamSnapshot.data!.docs.length;
                                    i++) {
                                  String snap =
                                      streamSnapshot.data!.docs[i]["name"];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snap,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      value: "${snap}",
                                    ),
                                  );
                                }
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  padding: EdgeInsets.only(
                                      right: 10, left: 20, top: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: DropdownButton<String>(
                                    items: currencyItems,
                                    onChanged: (currencyValue) {
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'Selected ID value is $currencyValue',
                                          style: TextStyle(
                                              color: Color(0xff11b719)),
                                        ),
                                      );
                                      setState(() {
                                        driverName = currencyValue;
                                      });
                                    },
                                    value: driverName,
                                    isExpanded: true,
                                    hint: new Text(
                                      "Choose Driver Name",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 15,
                        ),
                        child: Text(
                          'Challan Date:',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 7, left: 15, bottom: 5, right: 17),
                        child: TextFormField(
                          onTap: () {
                            _selectDate(context);
                          },
                          readOnly: true,
                          style: TextStyle(color: Colors.black),
                          controller: dateController,
                          decoration: InputDecoration(
                            hintText: 'Choose date',

                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 24),
                            //borderSide: BorderSide(color: Colors.black),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                        child: Text(
                          'Vehicle Number:',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: Expanded(
                          child: StreamBuilder(
                            stream: allRoutes,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (!streamSnapshot.hasData)
                                return Center(child: Text("Loading....."));
                              else {
                                List<DropdownMenuItem<String>> currencyItems =
                                    [];
                                for (int i = 0;
                                    i < streamSnapshot.data!.docs.length;
                                    i++) {
                                  String snap =
                                      streamSnapshot.data!.docs[i]["vehicleno"];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snap,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      value: "${snap}",
                                    ),
                                  );
                                }
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  padding: EdgeInsets.only(
                                      right: 10, left: 20, top: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: DropdownButton<String>(
                                    items: currencyItems,
                                    onChanged: (currencyValue) {
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'Selected ID value is $currencyValue',
                                          style: TextStyle(
                                              color: Color(0xff11b719)),
                                        ),
                                      );
                                      setState(() {
                                        vehicleNo = currencyValue;

                                      });
                                    },
                                    value: vehicleNo,
                                    isExpanded: false,
                                    hint: new Text(
                                      "Choose Vehicle Number",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
              elevation: 10,
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 5),
                //width: double.infinity, height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                            child: Text(
                              'Driver Rank:',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue,

                                // Down Arrow Icon


                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 15,
                            ),
                            child: Text(
                              'Challan Time:',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.only(
                              left: 20,top:5,
                            ),
                            child: Text(formattedDate.toString(), style: MyText.body2(context)!.copyWith(color: MyColors.grey_90, fontSize: 15)),


                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                            child: Text(
                              'Challan Type:',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue1,

                                // Down Arrow Icon


                                // Array list of items
                                items: items1.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                isExpanded: true,
                                itemHeight: null,
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue1 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 3),
              elevation: 10,
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 5),
                //width: double.infinity, height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                            child: Text(
                              'Challan Description:',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue2,


                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items2.map((String items) {
                                  return DropdownMenuItem(

                                    value: items,
                                    child: Container(

                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child:  Text(items),
                                      ),




                                  );
                                }).toList(),

                                isExpanded: true,
                                itemHeight: null,
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue2 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 15, bottom: 5),
                            child: Text(
                              'Challan Fine:',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: DropdownButton(
                                // Initial Value
                                value: dropdownvalue3,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items3.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue3 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            onPressed: () async{
              sBuilder(context);
            getToken(driverId.toString());
            DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
                "driver").doc(driverId).get();
            String token = snap['token'];
              sendPushMessage(token, dropdownvalue2, dropdownvalue1);
            postDetailsToFirestoreNotification(driverName,dropdownvalue1,dropdownvalue2,'${loggedInUser.OfficerName}');
              },
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.75,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            color: const Color(0xff152e57),
            child: const Text(
              'Generate',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );

  }

  postDetailsToFirestoreNotification(String name,String title,String description,String officerName) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    NotificationModel notificationModel= NotificationModel();
    notificationModel.officerName = officerName;
    notificationModel.Username = name;
    notificationModel.Notificationtitle = title;
    notificationModel.Notificationdescription = description;
    await firebaseFirestore
        .collection("notifications")
        .doc()
        .set(notificationModel.toMapNotificationOfficer());
  }
Widget sBuilder(BuildContext context){

    return Container(
      child: StreamBuilder(
        stream: foundOfficers,
        builder:
            (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          List<Widget> Data = [];
          var image_2;
          final product = streamSnapshot.data?.docs;
          return product?.length != 0
              ? SingleChildScrollView(
            child: Column(children: [
              for (var data in product!)

                FutureBuilder<String>(
                    builder: (_, imageSnapshot) {
                      final imageUrl = imageSnapshot.data;
                      if(data['name']==driverName){
                        getID(data.id);
                      }
                      return SizedBox(child: Text(data.id.toString()),);
                    })
            ]),
          )
              : SizedBox(height: 0,);
        },
      ),
    );
}

//Get from gallery

}
