import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/controllers/MenuController.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/allDriversInfo.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/dashboard_screen.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:fyp_survilence_system/utils/color.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => signupState();
}

class signupState extends State<signup> {
  TextEditingController ID = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phoneno = TextEditingController();
  TextEditingController CNIC = TextEditingController();
  TextEditingController DrivingRank = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Password = TextEditingController();
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
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              image: DecorationImage(
                image: AssetImage('assets/driverimg.PNG'),
                fit: BoxFit.fill,
              ),),),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Add New Driver',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: welcome_color),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'To add a new account enter driver details',
            style: TextStyle(fontSize: 14,color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                textwidget(ID,'Driver ID'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(Name,'Name'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(Email,'Email'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(Phoneno,'Phoneno'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(CNIC,'CNIC'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(DrivingRank,'Driving Rank'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(Address,'Address'),
                const SizedBox(
                  height: 20,
                ),
                textwidget(Password,'Password'),
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
          onPressed: () async {await signUp(Email.text,Password.text);},
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

  Widget textwidget(TextEditingController ctr,hinttext){
    return  SizedBox(
      height:40,
      child: TextFormField(
        keyboardType: hinttext=='Phoneno'||hinttext=='CNIC'? TextInputType.number:TextInputType.name,
        style: TextStyle(color: Colors.black),
        controller: ctr,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            hintText: '$hinttext',  hintStyle: TextStyle(fontSize: 15, color: Colors.black38),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
      ),
    ),);
  }
  signUp(String email, String password) async {

      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async =>
          { await postDetailsToFirestore(),
          })
          .catchError((e) {
        Fluttertoast.showToast(msg:e.toString().split("]")[1]);
        print('the error is $e');
      });
      }
  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    DriverModel driverModel= DriverModel();
    driverModel.driverId = ID.text;
    driverModel.name = Name.text;
    driverModel.email = Email.text;
    driverModel.phoneno= Phoneno.text;
    driverModel.cnic= CNIC.text;
    driverModel.drivingrank= DrivingRank.text;
    driverModel.address = Address.text;
    driverModel.password = Password.text;


    await firebaseFirestore
        .collection("driver")
        .doc(user!.uid)
        .set(driverModel.toMapDriver());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DriversTable()));
  }
}
