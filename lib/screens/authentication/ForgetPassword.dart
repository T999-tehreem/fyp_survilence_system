import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import '../../model/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/color.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController Email = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  DriverModel loggedInUser = DriverModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("driver")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = DriverModel.fromMapDriver(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      centerTitle: true,
      title: Text('FORGOT PASSWORD'),
      backgroundColor: Color(0xb00b679b),
    ),
      body: SingleChildScrollView(
      child: Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
      ),
    Container(
    height: 180.0,
    width: 220.0,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/logo.png'),
    fit: BoxFit.fill,
    ),),),
      const Text(
        'Forgot your',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Password?',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
          Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: const Text(
          'Lost your password? Please enter your email address. You will receive a link to reset your password via email.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),),
      const SizedBox(
        height: 30,
      ),

      Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child:
          TextFormField(
            style: TextStyle(color: Colors.white),
      controller: Email,
      decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors. white),
              borderRadius: BorderRadius.circular(10),
          )),
    ),),
      const SizedBox(
        height: 20,
      ),
    Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Align(alignment: Alignment.bottomRight,

      child: MaterialButton(
        onPressed: (){
          resetPassword(Email.text);
        },
        height: MediaQuery.of(context).size.height * 0.05,
        minWidth: MediaQuery.of(context).size.width * 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),),
        color: Color(0xb00b679b),
        child: const Text(
          'Send',
          style: TextStyle(color: Colors.white),
        ),
      ),),),
    ],),),);
  }
  @override
  Future<void> resetPassword(String email) async {
    if (loggedInUser.email==Email.text){
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "Email sent successfully!");
    }
    else {
      Fluttertoast.showToast(msg: "Email is incorrect!");
    }
  }
}
