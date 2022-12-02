import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/main.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/DriverDummyDashboard.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverSignup.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/nav_bar.dart';
import 'package:fyp_survilence_system/screens/authentication/ForgetPassword.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/UpdateDriverProfile.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/addnewdriver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_survilence_system/screens/camera/home_page.dart';
import '../../utils/color.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_dashboard/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),),
      backgroundColor: Colors.white,
      body:Center(
        child: SingleChildScrollView( child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/justlogo.PNG',),),
          const SizedBox(
            height: 20,
          ),
           Text(
            'Welcome',
            style: GoogleFonts.lobster(fontSize: 40,color: welcome_color),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: email,
                  decoration: const InputDecoration(hintText: 'Email ID',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black26),),

                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black26),),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          MaterialButton(
            onPressed: (){
              signIn(email.text,password.text);
            },
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.78,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),),
            color: const Color(0xb00b679b),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ForgetPassword()));
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children:[
            Text(
            'New Here?',
            style: TextStyle(color: Colors.black,),
          ),
                GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => driverSignup()));
            },
            child: const Text(
              ' Create an account',
              style: TextStyle(color: Colors.black, decoration: TextDecoration.underline ),
            ),
                ), ],),
          const SizedBox(
            height: 10,
          ),
                ]),
    ),
      ),);
  }// log
  Location location = new Location();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var prefs;

// in function
  Future<void> signIn(String email, String password) async {
    if(email.isEmpty||password.isEmpty){
      Fluttertoast.showToast(msg: "please fill all the fields first");

    }else {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid)async =>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        print(uid),

     await location.getLocation().then((value) async=> {


      await firebaseFirestore
         .collection("driver")
         .doc(uid!.user!.uid)
         .update({
     'lat':'${value.latitude}',
     'lng':'${value.longitude}'
     }),
      await firebaseFirestore
           .collection("driver")
           .doc(uid!.user!.uid)
           .get().then((value)async => {

      prefs = await SharedPreferences.getInstance(),
      await prefs.setString('driverID', value['driverId']),



          print('the lat is'),



         print(value['lat'])
           })



     }),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage())),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Incorrect Email or Password");
      });
    }
    
  }

}
