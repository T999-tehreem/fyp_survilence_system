import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/model/policeofficer_model.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/TrafficPoliceOperator/allTPInfo.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:fyp_survilence_system/utils/color.dart';

class AddTP extends StatefulWidget {
  const AddTP({Key? key}) : super(key: key);

  @override
  State<AddTP> createState() => _AddTPState();
}

class _AddTPState extends State<AddTP> {
  TextEditingController OfficerName = TextEditingController();
  TextEditingController officer_id = TextEditingController();
  TextEditingController off_id = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController Phoneno = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Rank = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController serviceStation = TextEditingController();
  bool ismale = true;

  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,

          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(45.0)),
                image: DecorationImage(
                  image: AssetImage('assets/TP.PNG'),
                  fit: BoxFit.fill,
                ),),),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Add Police Operator',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                  color: welcome_color),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'To add a new account enter police operator details',
              style: TextStyle(fontSize: 14,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                children: [
                  textwidget(OfficerName,'Name'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(officer_id,'Email_ID'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(off_id,'Officer_ID'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Phoneno,'Phone no'),
                  const SizedBox(
                    height: 20,
                  ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Select gender:', style: TextStyle(color: Colors.black)),
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              ismale = true;
                            });
                          },
                          icon: Icon(
                            ismale
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: Colors.black,
                            size: 15,
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      text2('Male', 14, Colors.black38),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            ismale = false;
                          });
                        },
                        icon: (Icon(
                          ismale
                              ? Icons.radio_button_off
                              : Icons.radio_button_checked,
                          color: Colors.black,
                          size: 15,
                        )),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      text2('Female', 14, Colors.black38),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Address,'Address'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Rank,'Rank'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Password,'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(serviceStation,'Service Station'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            onPressed: ()async {await signUp(officer_id.text,Password.text);},
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),),
            color: Color(0xff152e57),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),],
    );

  }
  Widget text2(dynamic text, double fontsize, Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        color: color,
      ),
    );
  }

  Widget textwidget(TextEditingController ctr,hinttext) {
    return
      SizedBox(
        height:40,
        child:
        TextFormField(
          keyboardType: hinttext=='Phoneno'||hinttext=='CNIC'?TextInputType.number:TextInputType.name,
          style: TextStyle(color: Colors.black),
          controller: ctr,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
              hintText: '$hinttext', hintStyle: TextStyle(fontSize: 15, color: Colors.black38),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),),
        ),

      );
  }
  signUp(String email, String password) async {

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async => {

        await postDetailsToFirestore(),
     })
        .catchError((e) {

          Fluttertoast.showToast(msg:e.toString().split("]")[1]);
          print('the error is $e');
    });
  }
  Future<dynamic>postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    OfficerModel officerModel= OfficerModel();
    officerModel.OfficerName = OfficerName.text;
    officerModel.officer_id = officer_id.text;
    officerModel.off_id = off_id.text;
    officerModel.gender = ismale==true?'male':'false';
    officerModel.phoneno= Phoneno.text;
    officerModel.address = Address.text;
    officerModel.rank = Rank.text;
    officerModel.password = Password.text;
    officerModel.serviceStation = serviceStation.text;

    await firebaseFirestore
        .collection("Officer")
        .doc(user!.uid)
        .set(officerModel.toMapOfficer());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const OfficersTable()));

  }
}


