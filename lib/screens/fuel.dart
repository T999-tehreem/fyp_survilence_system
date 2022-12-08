import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';

class Fuel extends StatefulWidget {
   Fuel({Key? key,required this.a}) : super(key: key);
  int a;
  @override
  State<Fuel> createState() => _FuelState();
}
class _FuelState extends State<Fuel> {
  final auth = FirebaseAuth.instance;
  DatabaseReference ab = FirebaseDatabase.instance.ref('test');
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/test');
  String data = '';
  double length = 26.355616809149;
  double width = 26.355616809149;
  late double volume = 0;

  double? litres;
  double? distance;
  @override
  void initState() {

    volumeCalculator();
    super.initState();
  }
  volumeCalculator(){

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF246587),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text('Fuel Comsumption Level'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage('assets/bus.png',),),
        Card(
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: <Widget>[
                Container(width: 10),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '* This shows the fuel consumped by ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  'the vehicle in litres and distance ',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'travelled in kilometers: ',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: Text( 'Litres Used: ${((26*26*26)-(26*26*(26-widget.a)))*0.016387064}',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: Text( 'Litres Remaining: ${((26*26*26)-(26*26*widget.a))*0.016387064}',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: Text( 'Kilometer Travelled: ${((26*26*26)-(26*26*(26-widget.a)))*0.016387064*15}',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
