import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import '../../../../services/database.dart';
import '../../../../utils/color.dart';
import '../chat/conversationScreen.dart';

class DriverChallanScreen extends StatefulWidget {
  const DriverChallanScreen({Key? key}) : super(key: key);

  @override
  State<DriverChallanScreen> createState() => _DriverChallanScreenState();
}

class _DriverChallanScreenState extends State<DriverChallanScreen> {

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
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Search', suffixIcon: Icon(Icons.search_off_rounded, color: Colors.black38)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 400,
                  child: StreamBuilder(

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
                                          Padding( padding: const EdgeInsets.fromLTRB(0, 0, 110, 0),
                                            child: Text(
                                              "",
                                              style: const TextStyle(fontSize: 14,color: Colors.black),
                                            ),),
                                          GestureDetector(
                                            onTap: () {


                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20.0)),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0),
                                              child: Icon(Icons.navigate_next_rounded, color: Colors.blueGrey),

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
                            style: TextStyle(fontSize: 18,color: Colors.white),
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


}