import 'package:flutter/material.dart';
import '../camera/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
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
                height: 400,
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
                                Card(
                                  elevation: 50,
                                  shadowColor: Colors.black,
                                  color: const Color(0xffffffff),
                                  child: SizedBox(
                                    width: 400,
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Text(streamSnapshot.data?.docs[index]["Notificationtitle"],style: TextStyle(
                                          fontWeight: FontWeight.bold),),//Text
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(streamSnapshot.data?.docs[index]["Notificationdescription"]),//SizedBox
                                        ],
                                      ), //Column
                                    ), //Padding
                                  ), //SizedBox
                                ),
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
