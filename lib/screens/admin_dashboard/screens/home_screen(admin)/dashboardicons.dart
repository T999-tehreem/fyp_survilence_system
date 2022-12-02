import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/tracking/AdminsideDriverListfortracking.dart';
import 'package:fyp_survilence_system/utils/color.dart';
import '../../../routes/routedashboard/allRoutesInfo.dart';
import '../../constants.dart';
import '../Driver/allDriversInfo.dart';
import '../TrafficPoliceOperator/allTPInfo.dart';

class DashboardIcons extends StatefulWidget {
  const DashboardIcons({Key? key}) : super(key: key);

  @override
  _DashboardIconsState createState() => _DashboardIconsState();
}

class _DashboardIconsState extends State<DashboardIcons> {

  int? totalImg = 0;
  int? totalAudio = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      decoration: BoxDecoration(
        color: Color(0xb00b679b),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RoutesTable()))
                },
                child: iconcard('Routes',Icons.route)),
            GestureDetector(
              onTap: () => {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>OfficersTable()))
              },
              child: iconcard('Statistics',Icons.bar_chart)),
            GestureDetector(
                onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DriversTable()))
                },
                child: iconcard('Driver',Icons.people_alt_rounded )),
          ],),
          SizedBox(height: defaultPadding),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OfficersTable()))
                  },
                  child: iconcard('Operator',Icons.local_police_outlined)),
              GestureDetector(
                onTap: () => {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>OfficersTable()))
                },
                child: iconcard('Notification',Icons.notifications_active)),
              GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDriverListForTracking()))
                  },
                child: iconcard('Track Vehicle',Icons.share_location_outlined)),
            ],),
        ],
      ),
    );
  }

  Widget iconcard(text,IconData icon){

    return Container(height: 100,
    width: MediaQuery.of(context).size.width*0.25,
    child: Card(elevation: 5.0, color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      Icon(icon,size: 30,color: Colors.black,),
        SizedBox(height: 10,),
        Align(alignment: Alignment.center,
        child: Text('$text',style: TextStyle(color: Colors.black, fontSize: 10),))
      ],
    ),
    ),);
  }
}
