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
import 'package:intl/intl.dart';

class CompanyChallanScreen extends StatefulWidget {
  const CompanyChallanScreen({Key? key}) : super(key: key);

  @override
  State<CompanyChallanScreen> createState() => _CompanyChallanScreenState();
}

class _CompanyChallanScreenState extends State<CompanyChallanScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> challanInfo = FirebaseFirestore.instance.collection('challan').snapshots();
  String dropdownvalue = 'All Challans';
  String dropdownvalue1 = 'All';

  // List of items in our dropdown menu
  var items = [
    'All Challans',
    'Pending',
    'Paid',
   ];
  var items1 = [
    'All',
    'Daily',
    'Monthly',
    'Yearly',

  ];
  DateTime now = DateTime.now();
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('EEE d MMM y').format(now);
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                            if(dropdownvalue=="All Challans"){
                              _runFilter("");
                            }
                            else{
                              _runFilter(dropdownvalue);
                            }

                          },
                        ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *0.15,),
                        DropdownButton(
                          value: dropdownvalue1,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items1.map((String items1) {
                            return DropdownMenuItem(
                              value: items1,
                              child: Text(items1),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue!;
                            });
                            if(dropdownvalue=="All"){
                              _runFilter("");
                            }
                             if(dropdownvalue1=="Daily"){
                              _runFilterDaily(formattedDate.toString().split(" ")[0]);
                            }
                             if(dropdownvalue1=="Monthly"){
                              _runFilterMonthly(formattedDate.toString().split(" ")[2]);
                            }
                            if(dropdownvalue1=="Yearly"){
                              _runFilterYearly(formattedDate.toString().split(" ")[3]);
                            }
                          },
                        ),
                      ],


                ),),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 400,
                  child: StreamBuilder(
                    stream: challanInfo,
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
                                              streamSnapshot.data?.docs[index]['challan_driver_name'],
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

  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('challan').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = challanInfo;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('challan')
          .where('status'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      challanInfo = results;
    });
  }
  void _runFilterDaily(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('challan').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = challanInfo;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('challan')
          .where('challan_day'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      challanInfo = results;
    });
  }
  void _runFilterMonthly(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('challan').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = challanInfo;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('challan')
          .where('challan_month'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      challanInfo = results;
    });
  }
  void _runFilterYearly(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('challan').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = challanInfo;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('challan')
          .where('challan_year'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      challanInfo = results;
    });
  }
}