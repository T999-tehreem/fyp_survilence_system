import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin_dashboard/screens/tracking/trackingdriver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
          padding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(widget.content),
        )
            : Container()
      ]),
    );
  }
}
class DriverScheduleNotification extends StatefulWidget {
  const DriverScheduleNotification({Key? key}) : super(key: key);

  @override
  State<DriverScheduleNotification> createState() => _DriverScheduleNotificationState();
}

class _DriverScheduleNotificationState extends State<DriverScheduleNotification> {
   String action ='';
   bool isloading = false;
  getdriverid()async{
    isloading =true;
    setState((){});
    final prefs = await SharedPreferences.getInstance();

   action = prefs.getString('driverID')!;

   print("my driver id is$action");

isloading = false;
    setState((){});


  }
   @override
   void initState() {
     super.initState();
     getdriverid();
   }


  // final Stream<QuerySnapshot<Map<String, dynamic>>> allDrivers =
  // FirebaseFirestore.instance.collection('routes').where('driverid',isEqualTo: action).snapshots();
  //

  @override
  Widget build(BuildContext context) {
   // getdriverid();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xb00d4d79),
          centerTitle: true,
          title: const Text(
            'Schedule',
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },

          ),

        ),
        body:

        isloading?Center(child: CircularProgressIndicator(),):    Row(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:   FirebaseFirestore.instance.collection('routes').where('driverid',isEqualTo: action).snapshots(),

                builder: (context,
                    AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData)
                    return Center(child: Text("Loading....."));
                  else {
                    var snap =
                    streamSnapshot.data!.docs;

                     return  ListView.builder(
                           itemCount: snap.length,
                           itemBuilder: (context,i){

                             var data = snap[i];


                             return  GestureDetector(
                               onTap: (){

                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackDriver(data:data)));
                               },
                               child: Accordion(
                                 title: '${data['startlocation']}',
                                 content:'${data['destinationlocation']}',
                               ),
                             );
                           })

                     ;}
                },
              ),
            ),
          ],
        ),
    );
  }
}
