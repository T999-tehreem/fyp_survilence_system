import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/fuel.dart';

class FuelDetection extends StatefulWidget {
  const FuelDetection({Key? key}) : super(key: key);

  @override
  State<FuelDetection> createState() => _FuelDetectionState();
}
class _FuelDetectionState extends State<FuelDetection> {
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

    setState(() {
      starCountRef.onValue.listen((DatabaseEvent event) {
        data = event.snapshot.value.toString();
      });
    });

    volumeCalculator();
    super.initState();
  }
  volumeCalculator(){
    int a = int.parse('2');
    volume = length*width *a;
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
          margin: EdgeInsets.fromLTRB(10, 20, 10, 80),
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: <Widget>[
                Container(width: 10),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '* This shows the fuel consumped by ',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'the vehicle in litres and distance ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'travelled in kilometers ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(40),
                  color: Color(0xb00b679b),
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    onPressed: () async{
                      print("pressed");
                      setState(() {
                        starCountRef.onValue.listen((DatabaseEvent event) {
                          data = event.snapshot.value.toString();
                        });
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Fuel(a: int.parse(data[4]))));
                    },
                    child: const Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
