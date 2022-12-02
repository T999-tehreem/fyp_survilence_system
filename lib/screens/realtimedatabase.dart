import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FuelDetection extends StatefulWidget {
  const FuelDetection({Key? key}) : super(key: key);

  @override
  State<FuelDetection> createState() => _FuelDetectionState();
}

class _FuelDetectionState extends State<FuelDetection> {
  final auth = FirebaseAuth.instance;
  DatabaseReference ab = FirebaseDatabase.instance.ref('test');
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/test');
  String? data ;
  @override
  void initState(){
    super.initState();
    starCountRef.onValue.listen((DatabaseEvent event) {
      data = event.snapshot.value.toString();
      print(data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children:[
       Expanded(

         child:
        Text(data.toString(),style: TextStyle(color: Colors.black),)
          ),],
    ),
    );

  }

}