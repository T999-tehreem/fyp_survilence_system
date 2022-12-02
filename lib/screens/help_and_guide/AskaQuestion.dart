import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/model/question_model.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/settings.dart';
import 'package:fyp_survilence_system/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/storage_model.dart';

class AskAQuestion extends StatefulWidget {
  const AskAQuestion({Key? key}) : super(key: key);

  @override
  State<AskAQuestion> createState() => _AskAQuestionState();
}

class _AskAQuestionState extends State<AskAQuestion> {
  TextEditingController emailController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget textwidget(TextEditingController ctr, hinttext) {
      return SizedBox(
        height: 40,
        child: TextFormField(
          keyboardType: hinttext == 'Phoneno' || hinttext == 'CNIC'
              ? TextInputType.number
              : TextInputType.name,
          style: TextStyle(color: Colors.white),
          controller: ctr,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            hintText: '$hinttext',
            hintStyle: TextStyle(fontSize: 15, color: Colors.white54),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xb00b679b),
        title: Text("Ask a Question"),
      ),
      backgroundColor:  Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/justlogo.PNG"),
              radius: 70,
              backgroundColor: Colors.white,

            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                controller: emailController,
                decoration: const InputDecoration(
                  fillColor: Colors.white10,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                controller: questionController,
                maxLines: 7,
                decoration: const InputDecoration(
                  fillColor: secondaryColor,
                  filled: true,
                  focusColor: secondaryColor,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
                  hintText: 'Ask a Question',
                  hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            MaterialButton(
              onPressed: () {
                postDetailsToFirestore();
              },
              height: MediaQuery.of(context).size.height * 0.07,
              minWidth: MediaQuery.of(context).size.width * 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              color: Color(0xb00b679b),
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final _auth = FirebaseAuth.instance;
  late Reference getUrl;
  final StorageModel storage = StorageModel();
  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    QuestionModel questionModel= QuestionModel();
    questionModel.email = emailController.text;
    questionModel.question = questionController.text;


    await firebaseFirestore
        .collection("questions")
        .doc(user!.uid)
        .set(questionModel.toQuestion());
    Fluttertoast.showToast(msg: "Your response has been submitted successfully. We will get back to you soon. :) ");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SettingProfileRoute()));
  }
}