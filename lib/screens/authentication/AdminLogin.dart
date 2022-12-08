import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/main.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/Utils/notifications.dart';
import 'package:fyp_survilence_system/screens/authentication/ForgetPassword.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/UpdateDriverProfile.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/addnewdriver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/color.dart';
import '../admin_dashboard/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../admin_dashboard/controllers/MenuController.dart';
import '../admin_dashboard/screens/home_screen(admin)/nav_bar.dart';
import '../admin_dashboard/screens/main/main_screen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController UserId = TextEditingController();
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/justlogo.PNG',),),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome',
              style: GoogleFonts.lobster(fontSize: 40, color: welcome_color),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'To access Admin Panel please enter your UserID and Password to proceed',
              textAlign: TextAlign.center,
              style: GoogleFonts.shanti(fontSize: 12, color: Colors.black),
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
                    controller: UserId,
                    decoration: const InputDecoration(
                      hintText: 'User ID',
                      hintStyle: TextStyle(
                          fontSize: 15, color: Colors.black26),),

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 15, color: Colors.black26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            MaterialButton(
              onPressed: (){
                signIn(UserId.text, password.text);
              },
              height: MediaQuery.of(context).size.height * 0.05,
              minWidth: MediaQuery.of(context).size.width * 0.78,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),),
              color: Color(0xff152e57),
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
              height: 10,
            ),
          ]),
        ),
      ),);
  } // login function
  Future<void> signIn(String UserId, String password) async {
    if (UserId.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "please fill all the fields first");
    } else {
      await _auth
          .signInWithEmailAndPassword(email: UserId, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successful",),
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminMain())),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Incorrect Email or Password");
      });
    }
  }
}
