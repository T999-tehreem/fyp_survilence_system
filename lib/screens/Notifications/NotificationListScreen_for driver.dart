import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import '../camera/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AllNotificationsForDriver extends StatefulWidget {
  const AllNotificationsForDriver({Key? key}) : super(key: key);

  @override
  State<AllNotificationsForDriver> createState() => _AllNotificationsForDriverState();
}

class _AllNotificationsForDriverState extends State<AllNotificationsForDriver> {
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user!.uid)
        .get()
        .then((value) {

      setState(() {
        loggedInUser = DriverModel.fromMapDriver(value.data());
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
                        streamSnapshot.data?.docs[index]['Username']==loggedInUser.name?
                            Card(
                              elevation: 50,
                              shadowColor: Colors.black,
                              color: const Color(0xffffffff),
                              child: SizedBox(
                                width: 400,
                                height: MediaQuery.of(context).size.height*.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(streamSnapshot.data?.docs[index]["Notificationtitle"],style: TextStyle(
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
