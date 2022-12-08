import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/DriverDummyDashboard.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/main/main_screen.dart';
import 'package:fyp_survilence_system/screens/authentication/ForgetPassword.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/UpdateDriverProfile.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/AssignRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/driver_model.dart';
import '../../../../services/database.dart';
import '../../../chat/DriverMessageScreen.dart';
import '../../../chat/conversationScreen.dart';
import '../../constants.dart';

class DriverNavbar extends StatefulWidget {

  @override
  _DriverNavbarState createState() => _DriverNavbarState();
}

class _DriverNavbarState extends State<DriverNavbar> {
  int _currentIndex = 0;
  int _counter = 0;
  int _selectedIndex = 0;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  createChatRoomAndStartConversation(String userName, String myName) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(myName, userName);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ConversationScreen(
                chatRoomId: chatRoomId, myName: myName, userName: userName,currentU: user!.uid,),
      ),
    );
  }
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMapDriver(value.data());
      setState(() {});
    });
  }


  static List<Widget> _widgetOptions = <Widget>[
    DriverDashboard(),
    DriverDashboard(),
    DriverMessageScreen(),
    DriverDashboard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),

      bottomNavigationBar: BottomNavyBar(
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
      ),
    );
  }
}
