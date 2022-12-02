import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_survilence_system/model/driver_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/model/storage_model.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/controllers/MenuController.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/allDriversInfo.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/dashboard_screen.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class driverSignup extends StatefulWidget {
  const driverSignup({Key? key}) : super(key: key);

  @override
  State<driverSignup> createState() => driverSignupState();
}

class driverSignupState extends State<driverSignup> {
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
  late Reference getUrl;
  final StorageModel storage = StorageModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black),
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
                children: [ Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      minWidth: MediaQuery.of(context).size.width * 0.2,
                      height: 70,
                      onPressed: () async {
                        _getFromGallery();
                      },
                      child: Column(children: [
                        imageFile==null? Icon(Icons.person, size: 35) :ClipRRect(
                          borderRadius: BorderRadius.circular(500.0),
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                            height: 70,
                            width: 70,
                          ),
                        ),

                      ],)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
            color: Color(0xb00b679b),
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
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10),
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
    driverModel.profileImage = getUrl.fullPath.toString();


    await firebaseFirestore
        .collection("driver")
        .doc(user!.uid)
        .set(driverModel.toMapDriver());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DriversTable()));
  }
  //Get from gallery
   File? imageFile;
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
