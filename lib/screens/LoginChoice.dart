import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/authentication/AdminLogin.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:fyp_survilence_system/screens/authentication/OfficerLogin.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({Key? key}) : super(key: key);

  @override
  State<LoginChoice> createState() => _LoginChoiceState();
}

class _LoginChoiceState extends State<LoginChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white54,
                  backgroundImage: AssetImage(
                    'assets/justlogo.PNG',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Welcome',
                  style:
                      GoogleFonts.lobster(fontSize: 30, color: welcome_color),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Text(
                    'Would You Like To Login As',
                    style:
                        GoogleFonts.lobster(fontSize: 18, color: welcome_color),
                  ),
                ),
                const SizedBox(height: 10),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 230),
                          child: GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                  backgroundColor: Color(0xB00B679B),
                            radius: 60,
                            child: CircleAvatar(
                                    backgroundColor: Color(0xff152e57),
                                    radius: 55, // Image radius
                                    child: Image.asset(
                                      'assets/admin.png',
                                      height: 80,
                                    ),
                                  ),),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: Text(
                                      'Admin',
                                      style: GoogleFonts.lobster(
                                          fontSize: 18, color: welcome_color),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminLogin()));
                              }),
                        ),
                        Text(''),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Padding(
                          padding: EdgeInsets.only(left: 170, top: 20),
                          child: GestureDetector(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xB00B679B),
                                  radius: 60,
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff152e57),
                                    radius: 55, // Image radius
                                    child: Image.asset(
                                        'assets/driver.png',
                                        height: 90,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: Text(
                                      'Driver',
                                      style: GoogleFonts.lobster(
                                          fontSize: 18, color: welcome_color),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              }),
                        ),
                        Text(''),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 250),
                          child: GestureDetector(
                            child: Column(
                              children: [
                                CircleAvatar(
                                backgroundColor: Color(0xB00B679B),
                            radius: 60,
                            child: CircleAvatar(
                                  backgroundColor: Color(0xff152e57),
                                  radius: 55, // Image radius
                                  child: Image.asset(
                                    'assets/policeofficer.png',
                                    height: 80,
                                  ),
                                ),),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                                  child: Text(
                                    'Officer',
                                    style: GoogleFonts.lobster(
                                        fontSize: 18, color: welcome_color),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfficerLogin()));
                            },
                          ),
                        ),
                        Text(''),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
