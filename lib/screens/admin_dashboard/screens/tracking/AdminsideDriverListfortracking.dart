import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_survilence_system/screens/Notifications/AdminTrackDriver.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/tracking/trackingdriver.dart';


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
class AdminDriverListForTracking extends StatefulWidget {
  const AdminDriverListForTracking({Key? key}) : super(key: key);

  @override
  State<AdminDriverListForTracking> createState() => _AdminDriverListForTrackingState();
}

class _AdminDriverListForTrackingState extends State<AdminDriverListForTracking> {

  final Stream<QuerySnapshot<Map<String, dynamic>>> allDrivers =
  FirebaseFirestore.instance.collection('routes').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color(0xb00b679b),
        centerTitle: true,
        title: const Text(
          'Track Drivers',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body:

      Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: allDrivers,
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

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminTrackDriver(data:data)));
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
