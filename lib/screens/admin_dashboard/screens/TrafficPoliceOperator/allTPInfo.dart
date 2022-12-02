import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/TrafficPoliceOperator/TPdetail/UpdatePoliceOfficerProfile.dart';
import '../../../../utils/color.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TPdetail/addpoliceofficer.dart';

class OfficersTable extends StatefulWidget {
  const OfficersTable({
    Key? key,
  }) : super(key: key);

  @override
  State<OfficersTable> createState() => _OfficerssTableState();
}

class _OfficerssTableState extends State<OfficersTable> {
  bool isloading = false;
  dynamic listofallusers = [];
  User? user = FirebaseAuth.instance.currentUser;
  OfficerModel loggedInUser = OfficerModel();
  final releaseTitleController = TextEditingController();
  final Stream<
      QuerySnapshot<Map<String, dynamic>>> allOfficers = FirebaseFirestore
      .instance
      .collection('Officer')
      .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print("im here ");
    return Scaffold(
      backgroundColor: bgColor,
      body: isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                nav(
                    context,
                    AddTP(
                    ));
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Chip(
                  backgroundColor: Color(0xb00b679b),
                  label: Text(
                    "Add New Operator",
                    style: TextStyle(color: Colors.white,),
                  ),
                ),
              ),
            ),
            Text(
              "Operators",
              style: TextStyle(color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                      'Name',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    'Rank',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Action',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 450,
              height: 400,
              child: StreamBuilder(
                stream: allOfficers,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      child: streamSnapshot.data?.docs.length != 0
                          ? ListView.builder(
                        itemCount: streamSnapshot.data?.docs.length,
                        itemBuilder: (ctx, index) =>
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                        Alignment.centerLeft,
                                        child: Text(
                                          streamSnapshot.data
                                              ?.docs[index]
                                          ['Officername'],
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 25,),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                        Alignment.centerLeft,
                                        child: Text(
                                          streamSnapshot.data
                                              ?.docs[index]["rank"],

                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15,),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 0.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                nav(
                                                    context,
                                                    UpdateOfficerProfile(data: streamSnapshot.data
                                                        ?.docs[index], ));
                                              },
                                              icon: Icon(Icons.edit,
                                                color: Colors.grey,)),
                                          IconButton(
                                              onPressed: () {
                                                print("im deleting");

                                                AwesomeDialog(
                                                  width: 500,
                                                  context: context,
                                                  animType: AnimType
                                                      .BOTTOMSLIDE,
                                                  title: 'Are You Sure',
                                                  desc: 'You want to delete',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () async {
                                                    await FirebaseFirestore.instance.collection('Officer').doc(streamSnapshot.data
                                                        ?.docs[index].id).delete();
                                                  },
                                                )
                                                  ..show();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.black,

                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                      )
                          : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ),),

          ],
        ),
      ),
    );
  }
}

