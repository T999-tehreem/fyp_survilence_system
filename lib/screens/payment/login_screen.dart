import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/payment/StripePayment.dart';
import 'package:fyp_survilence_system/utils/color.dart';
import 'home_screen.dart';

class LoginScreenOTP extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<void> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if (user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: user,
                      )));
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (Exception exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Confirm"),
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);

                      UserCredential result =
                          await _auth.signInWithCredential(credential);

                      User? user = result.user;

                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StripePayment(
                                      mobileNumber: _phoneController.text,
                                    )));
                      } else {
                        print("Error");
                      }
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

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
        body: Center(
        child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/phoneverifyimg.PNG',),),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Verification",
                    style: TextStyle(
                        color: welcome_color,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "We will send you OTP Verification Code",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "on your phone number.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Enter Phone No", hintStyle: TextStyle(fontSize: 15, color: Colors.black38),),

                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              /*Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("GET OTP"),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);
                  },
                ),
              )*/
              MaterialButton(
                onPressed: (){
                  final phone = _phoneController.text.trim();
                  loginUser(phone, context);
                },
                height: MediaQuery.of(context).size.height * 0.05,
                minWidth: MediaQuery.of(context).size.width * 0.78,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),),
                color: Color(0xff152e57),
                child: const Text(
                  'GET OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
