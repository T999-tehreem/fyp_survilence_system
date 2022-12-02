import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import '../../../../services/database.dart';
import '../../../../utils/color.dart';
import '../chat/conversationScreen.dart';

class DriverMessageScreen extends StatefulWidget {
  const DriverMessageScreen({Key? key}) : super(key: key);

  @override
  State<DriverMessageScreen> createState() => _DriverMessageScreenState();
}

class _DriverMessageScreenState extends State<DriverMessageScreen> {


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
        builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId, myName: myName, userName: userName),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Chat"),
      backgroundColor: Color(0xb00b679b)),
      body: SingleChildScrollView(
child: Padding(
  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CircleAvatar(
        backgroundColor: Colors.black,
        child: Icon(Icons.person),
      ),
      Padding(padding: EdgeInsets.only(right: 130),
          child: Text("Admin", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),),
      GestureDetector(
        onTap: (){
          createChatRoomAndStartConversation("admin", loggedInUser.name.toString());
        },
        child: Icon(Icons.message_rounded, size: 35, color: Colors.black),
      ),
    ],
  ),
)
      ),);
  }


}