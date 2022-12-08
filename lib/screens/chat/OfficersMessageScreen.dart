import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import '../../../../services/database.dart';
import '../../../../utils/color.dart';
import '../chat/conversationScreen.dart';

class OfficerMessageScreen extends StatefulWidget {
  const OfficerMessageScreen({Key? key}) : super(key: key);

  @override
  State<OfficerMessageScreen> createState() => _OfficerMessageScreenState();
}

class _OfficerMessageScreenState extends State<OfficerMessageScreen> {


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
  OfficerModel loggedInUser = OfficerModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("officer")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = OfficerModel.fromMapOfficer(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Chat"),
          backgroundColor: Color(0xb00d4d79)),
      body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('ChatRoom').snapshots(),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: streamSnapshot.data?.docs.length != 0
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data?.docs.length,
                      itemBuilder:
                          (ctx, index) =>
                      (streamSnapshot
                          .data
                          ?.docs[index].id.split("_")[0]
                          ==
                          user!.uid || streamSnapshot
                          .data
                          ?.docs[index].id.split("_")[1]
                          ==
                          user!.uid)
                          ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(Icons.person),
                            ),
                            Padding(padding: EdgeInsets.only(right: 100),
                              child: Text("Admin", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),),
                            GestureDetector(
                              onTap: (){
                                if(loggedInUser.OfficerName==streamSnapshot.data?.docs[index]['users'][0]){
                                  if(user!.uid==streamSnapshot.data?.docs[index].id.split("_")[1]){
                                    createChatRoomAndStartConversation(streamSnapshot.data?.docs[index]['users'][1],loggedInUser.OfficerName.toString(),
                                        user!.uid,"${streamSnapshot.data?.docs[index].id.split("_")[0]}");
                                  }
                                  else{
                                    createChatRoomAndStartConversation(streamSnapshot.data?.docs[index]['users'][1],loggedInUser.OfficerName.toString(),
                                        user!.uid,"${streamSnapshot.data?.docs[index].id.split("_")[1]}");
                                  }

                                }
                                else{
                                  if(user!.uid==streamSnapshot.data?.docs[index].id.split("_")[1]) {
                                    createChatRoomAndStartConversation(
                                        streamSnapshot.data
                                            ?.docs[index]['users'][0],
                                        loggedInUser.OfficerName
                                            .toString(),
                                        user!.uid,
                                        "${streamSnapshot.data
                                            ?.docs[index].id.split(
                                            "_")[0]}");
                                  }
                                  else{
                                    createChatRoomAndStartConversation(
                                        streamSnapshot.data
                                            ?.docs[index]['users'][0],
                                        loggedInUser.OfficerName
                                            .toString(),
                                        user!.uid,
                                        "${streamSnapshot.data
                                            ?.docs[index].id.split(
                                            "_")[1]}");
                                  }
                                }
                              },
                              child: Icon(Icons.message_rounded, size: 35, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                          : const Text(
                        '',
                        style:
                        TextStyle(fontSize: 0),
                      ),
                    )
                        : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
      ),);
  }


}