import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/Challan/DriverChallanDetails.dart';
import '../../model/driver_model.dart';
import '../camera/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverChallanHistoryfromDriverSide extends StatefulWidget {
  const DriverChallanHistoryfromDriverSide({Key? key}) : super(key: key);

  @override
  State<DriverChallanHistoryfromDriverSide> createState() => _DriverChallanHistoryfromDriverSideState();
}

class _DriverChallanHistoryfromDriverSideState extends State<DriverChallanHistoryfromDriverSide> {
  Stream<QuerySnapshot<Map<String, dynamic>>> challanInfo = FirebaseFirestore.instance.collection('challan').snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  String dropdownvalue = 'All Challans';
  String dropdownvalue1 = 'All';
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
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMapDriver(value.data());
      setState(() {});
    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xb00b679b),
        title: const Text(
          'Challan History',
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
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
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
                      width: 450,
                      height: 400,
                      child: StreamBuilder(
                        stream: FirebaseFirestore
                            .instance
                            .collection('challan')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                          return (streamSnapshot.hasData?Padding(
                            padding: const EdgeInsets.all(20),
                            child: Expanded(
                              // ignore: prefer_is_empty
                              child: streamSnapshot.data?.docs.length != 0
                                  ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: streamSnapshot.data?.docs.length,
                                itemBuilder: (ctx, index) =>
                                loggedInUser.name.toString()==streamSnapshot.data?.docs[index]['challan_driver_name'].toString()?
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
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>ChallanDetailsScreen(
                                                    vehicleNo: streamSnapshot.data?.docs[index]['challan_vehicle_no'],
                                                    name: streamSnapshot.data?.docs[index]['challan_driver_name'],
                                                    rank: streamSnapshot.data?.docs[index]['challan_driver_rank'],
                                                    challan_description: streamSnapshot.data?.docs[index]['challan_description'],
                                                    challan_no: streamSnapshot.data?.docs[index]['Challan_no'],
                                                    challan_time: streamSnapshot.data?.docs[index]['challan_time'],
                                                    challan_type: streamSnapshot.data?.docs[index]['challan_type'],
                                                    fine: streamSnapshot.data?.docs[index]['challan_fine'])));
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
                                ):const SizedBox(),
                              )
                                  : const Text(
                                'No results found',
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                          ):Center(child: CircularProgressIndicator(),));},
                      ),),
                  ],
                )),

            const SizedBox(
              height: 10,
            ),
          ],),





      ),

    );
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