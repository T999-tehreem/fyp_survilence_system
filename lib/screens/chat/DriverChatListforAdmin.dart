import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import '../../../../services/database.dart';
import '../../../../utils/color.dart';
import '../../model/admin_model.dart';
import '../chat/conversationScreen.dart';

class DriverChatListScreen extends StatefulWidget {
  const DriverChatListScreen({Key? key}) : super(key: key);

  @override
  State<DriverChatListScreen> createState() => _DriverChatListScreenState();
}

class _DriverChatListScreenState extends State<DriverChatListScreen> {
  final Stream<QuerySnapshot<Map<String,
      dynamic>>> allDrivers = FirebaseFirestore.instance.collection('driver').snapshots();
  Stream<QuerySnapshot<Map<String,
      dynamic>>> foundDriver = FirebaseFirestore.instance.collection('driver').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoomAndStartConversation(String userName, String myName,String uid,String uid2) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(uid, uid2);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(
          chatRoomId: chatRoomId, myName: myName, userName: userName, currentU: user!.uid,),
      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminModel loggedInUser = AdminModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("admin")
        .doc("NDpiCLbSoXVOvNJqoZVM")
        .get()
        .then((value) {
      loggedInUser = AdminModel.fromMapAdmin(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25,5,25,0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black38),
                      labelText: 'Search', suffixIcon: Icon(Icons.search_off_rounded,color: Colors.black38)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 400,
                child: StreamBuilder(
                  stream: foundDriver,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Expanded(
                        child: streamSnapshot.data?.docs.length != 0
                            ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data?.docs.length,
                          itemBuilder: (ctx, index) =>
                              Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(Icons.person),
                                  ),
                                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 110, 0),
                                  child: Text(
                                    "${streamSnapshot.data?.docs[index]['name']}",
                                    style: const TextStyle(fontSize: 14,color: Colors.black),
                                  ),),
                                  GestureDetector(
                                    onTap: () {

                                      createChatRoomAndStartConversation(
                                          streamSnapshot.data?.docs[index]
                                          ['name'],
                                          'admin','${streamSnapshot.data?.docs[index].id}',user!.uid);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0),
                                      child: Icon(Icons.message_rounded,color: Colors.black),

                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        )
                            : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 18,color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    ),);
  }

  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('driver').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allDrivers;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('driver')
          .where('name'.toString(), isEqualTo: '$enteredKeyword'.toString())
          .snapshots();
    }
    // Refresh the UI
    setState(() {
      foundDriver = results;
    });
  }
}