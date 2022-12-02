import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp_survilence_system/utils/color.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../Challan/challan.dart';
import '../admin_dashboard/screens/Driver/DriverDummyDashboard.dart';
import '../chat/DriverMessageScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? selectedImage;
  File? second_Image;
  String? message = "";
  String? seat_belt="";
  String? bg_image = "";
  int timer = 5;
  bool canceltimer = false;
  String showtimer = "5";
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  void getTokenOfficer() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            mtoken = token;
            print("My token is $mtoken");
          });
          saveToken(token!);
        }
    );
  }

  void saveTokenOfficer(String token) async{
    await FirebaseFirestore.instance.collection("admin").doc("NDpiCLbSoXVOvNJqoZVM").update({
      'token' : token,
    });
  }

  void listenFCMOfficer() async {
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

  void loadFCMOfficer() async {
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

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            mtoken = token;
            print("My token is $mtoken");
          });
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async{
    await FirebaseFirestore.instance.collection("admin").doc("NDpiCLbSoXVOvNJqoZVM").update({
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
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      if(mounted) {
        setState(() {
          if (timer < 1) {
            takePicture();
            timer = 5;

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
  void initState() {
    super.initState();
    starttimer();
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();

    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      selectedImage = File(picture.path);
      uploadImage();

    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
  uploadImage() async{
    timer = 120;
   final request = http.MultipartRequest(
        "POST" , Uri.parse("https://d098-203-124-40-245.eu.ngrok.io/upload")
    );
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    seat_belt = resJson['message_2'];
    print(message);
    print(seat_belt);
    second_Image = selectedImage;

    setState(() {
      selectedImage = null;
    });
   /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(0.0),
            backgroundColor: Colors.white,
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(second_Image! ,
                    height: 150,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Results: ",
                        style: TextStyle(
                            color: Colors.cyan[800], fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      message!,
                      style: TextStyle(
                          color: Colors.teal[900]
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Seat: ",
                        style: TextStyle(
                            color: Colors.cyan[800], fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      seat_belt!,
                      style: TextStyle(
                          color: Colors.teal[900]
                      ),
                    )
                  ],
                ),

              ],
            ),
          );
        });*/
    if (message=="tired" || seat_belt=="No_Seatbelt"){
      int timer2 = 10;
      FlutterRingtonePlayer.playAlarm();
      const onesec = Duration(seconds: 1);
      Timer.periodic(onesec, (Timer t) {
        if(mounted) {
            setState(() {
            if (timer2 < 1) {
              FlutterRingtonePlayer.playAlarm(asAlarm: false);
              } else if (canceltimer == true) {
              t.cancel();
            } else {
              timer2 = timer2 - 1;
            }
            showtimer = timer2.toString();
          });
        }
      });
      if(message=='tired' && seat_belt=='No_Seatbelt'){
        DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
            "admin").doc('NDpiCLbSoXVOvNJqoZVM').get();
        String token = snap['token'];
        print(token);
        sendPushMessage(token, 'Challan generated due to tiredness and seatbelt violation', message.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallanScreen(challantype:'Seatbelt voilation and drowsy state',ChallanDetails:'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for seatbelt violation and is being fined for driving the vehicle in drowsy state. The concerned person needs to pay the fine amount within the deadline strictly.',ChallanFine:1000)));
      }
      if(message=='tired'){
        DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
            "admin").doc('NDpiCLbSoXVOvNJqoZVM').get();
        String token = snap['token'];
        print(token);
        sendPushMessage(token, 'Challan generated due to tiredness', message.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallanScreen(challantype:'Drowsy State',ChallanDetails:'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for driving the vehicle in drowsy state. The concerned person needs to pay the fine amount within the deadline strictly.',ChallanFine:700)));
      }
      if(seat_belt=='No_Seatbelt'){
        DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
            "admin").doc('NDpiCLbSoXVOvNJqoZVM').get();
        String token = snap['token'];
        print(token);
        sendPushMessage(token, 'Challan generated due to seatbelt violation', message.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallanScreen(challantype:'Seatbelt voilation ',ChallanDetails:'The driver is being charged for violating the driving laws of Islamabad Traffic Police under THE PROVINCIAL MOTOR VEHICLES ORDINANCE 1965 for seatbelt violation. The concerned person needs to pay the fine amount within the deadline strictly.',ChallanFine:300)));
      }


    }
    timer = 5;
  }
  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
  static List<Widget> _widgetOptions = <Widget>[
    DriverDashboard(),
    DriverDashboard(),
    DriverMessageScreen(),
    DriverDashboard(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*bottomNavigationBar: BottomNavyBar(

          backgroundColor: Color(0xffAFE1AF),

          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Users'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Messages',
              ),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),*/
        body: SafeArea(
          child: Stack(children: [
            (_cameraController.value.isInitialized)
                ? CameraPreview(_cameraController)
                : Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.1,
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffAFE1AF),
                      ),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      color: Color(0xffAFE1AF),

                    ),

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(

                            onPressed: () {
                              setState(
                                      () => _isRearCameraSelected = !_isRearCameraSelected);
                              initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                            },
                            icon: Icon(_isRearCameraSelected
                                ? CupertinoIcons.switch_camera
                                : CupertinoIcons.switch_camera_solid,
                              color: Colors.black, size: 35,),
                          ),


                        ),




                      ],
                    )
                )),
          ]),
        ));
  }
}