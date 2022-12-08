import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../model/policeofficer_model.dart';

class UpdateOfficerProfile extends StatefulWidget {
  dynamic data;
  UpdateOfficerProfile({Key? key,this.data}) : super(key: key);

  @override
  State<UpdateOfficerProfile> createState() => _UpdateOfficerProfileState();
}

class _UpdateOfficerProfileState extends State<UpdateOfficerProfile> {
  TextEditingController serviceStation = TextEditingController();
  TextEditingController Phoneno = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController OfficerRank = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    serviceStation.text = widget.data['serviceStation'];
    Phoneno.text = widget.data['phoneno'];
    Address.text = widget.data['address'];
    OfficerRank.text = widget.data['rank'];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xb00d4d79),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body:   SingleChildScrollView(
        child:  Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height*0.27,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xb00b679b),Colors.white],
                  stops: [0.5, 0.5],
                ),
              ),

              child:Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child:
                  CircleAvatar(
                      radius:60,
                      backgroundImage: AssetImage('assets/profileicon.PNG',)),
                ),),
              ],),),
            const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter new details to update your officer profile',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                children: [
                  textwidget(serviceStation,'Service Station'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Phoneno,'Phone no'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(Address,'Address'),
                  const SizedBox(
                    height: 20,
                  ),
                  textwidget(OfficerRank,'Rank'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],),),),
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            onPressed: ()async{
              await FirebaseFirestore.instance.collection('Officer').doc(widget.data.id).update({
                'serviceStation':serviceStation.text,
                'rank':OfficerRank.text,
                'phoneno': Phoneno.text,
                'address':Address.text,
              });
              Navigator.pop(context);
            },
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),),
            color: Color(0xff152e57),
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),],
    );
  }
  Widget textwidget(TextEditingController ctr,hinttext){
    return  SizedBox(
      height:40,
      child: TextFormField(
        keyboardType: hinttext=='Phoneno'||hinttext=='CNIC'?TextInputType.number:TextInputType.name,
        style: TextStyle(color: Colors.black),
        controller: ctr,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          hintText: '$hinttext',  hintStyle: TextStyle(fontSize: 15, color: Colors.black38),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),

        ),
      ),);
  }
}