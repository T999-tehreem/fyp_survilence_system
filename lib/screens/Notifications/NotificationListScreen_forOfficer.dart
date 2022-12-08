import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import '../camera/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AllNotificationsForOfficer extends StatefulWidget {
  const AllNotificationsForOfficer({Key? key}) : super(key: key);

  @override
  State<AllNotificationsForOfficer> createState() => _AllNotificationsForOfficerState();
}
class _AllNotificationsForOfficerState extends State<AllNotificationsForOfficer> {
  User? user = FirebaseAuth.instance.currentUser;
  OfficerModel loggedInUser = OfficerModel();
  @override
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      appBar: AppBar(
        backgroundColor: Color(0xb00b679b),
        title: const Text(
          'Notifications',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 450,
              height: MediaQuery.of(context).size.height*1,
              child: StreamBuilder(
                stream: FirebaseFirestore
                    .instance
                    .collection('notifications')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                  return (streamSnapshot.hasData?Padding(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      // ignore: prefer_is_empty
                      child: streamSnapshot.data?.docs.length != 0
                          ? ListView.builder(
                        itemCount: streamSnapshot.data?.docs.length,
                        itemBuilder: (ctx, index) =>
                        loggedInUser.OfficerName == streamSnapshot.data?.docs[index]['officerName']?
                            Card(
                              elevation: 50,
                              shadowColor: Colors.black,
                              color: const Color(0xffffffff),
                              child: SizedBox(
                                width: 400,
                                height: MediaQuery.of(context).size.height*.25,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text('Reason: ${streamSnapshot.data?.docs[index]["Notificationtitle"]}',style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                      Text('Driver Name: ${streamSnapshot.data?.docs[index]["Notificationtitle"]}',style: TextStyle(
                                          fontWeight: FontWeight.bold),),//Text
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(streamSnapshot.data?.docs[index]["Notificationdescription"],overflow:TextOverflow.ellipsis, maxLines: 4),//SizedBox
                                    ],
                                  ), //Column
                                ), //Padding
                              ), //SizedBox
                            ):const SizedBox(),
                      )
                          : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ):Center(child: CircularProgressIndicator(),));},
              ),),
            const SizedBox(
              height: 10,
            ),
          ],),





      ),

    );
  }
}
