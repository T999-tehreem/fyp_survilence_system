import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/main.dart';
import 'package:fyp_survilence_system/screens/Fuel_detection.dart';
import 'package:fyp_survilence_system/screens/Notifications/NotificationListScreen.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/nav_bar.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/tracking/AdminsideDriverListfortracking.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/statistics.dart';
import 'package:fyp_survilence_system/screens/chat/chatTopNavBar.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/Admin_settings_Screen.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/settings.dart';
import 'package:fyp_survilence_system/screens/payment/login_screen.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/allRoutesInfo.dart';
import 'package:fyp_survilence_system/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../chat/DriverChatListforAdmin.dart';
import '../../controllers/MenuController.dart';
import '../Driver/allDriversInfo.dart';
import '../TrafficPoliceOperator/allTPInfo.dart';
import 'main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
      DrawerHeader(
      child: Column(
      children: const [
        CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/justlogo.PNG',),),
      SizedBox(height: 10),
      Center(
        child: Text(
          'Accident Prevention System',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ],
    )
    ),

    ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    leading: const Icon(Icons.dashboard),
    title: const Text("DASHBOARD"),
    onTap: ()  {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MultiProvider(
    providers: [
    ChangeNotifierProvider(
    create: (context) => MenuController(),
    ),
    ],
    child: MainScreen(),
    ),
    ));
    },
    ),
          //dashboard
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.route),
              title: const Text("ROUTES"),
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>const RoutesTable()))
          ),

          Padding(
            padding: const EdgeInsets.only(left:0.0),
            child: ExpansionTile(
              leading: const Icon(Icons.supervisor_account_rounded),
              title: Text("USERS", style: TextStyle(color: Colors.white),),
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () => {Navigator.push(context,MaterialPageRoute(builder: (context)=>const DriversTable())),},
                    child: Padding(
                    padding: EdgeInsets.only(left:71.0),
                    child: Text("DRIVER", style: TextStyle(color: Colors.white),),
                  ),
                ),),

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => {Navigator.push(context,MaterialPageRoute(builder: (context)=>const OfficersTable())),},
                    child: Padding(
                      padding: EdgeInsets.only(left:71.0, bottom: 5.0),
                      child: Text("STATION OPERATOR", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),],
            ),
          ),

          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.notifications),
              title: const Text("NOTIFICATIONS"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNotifications()))
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.bar_chart_rounded),
              title: const Text("STATISTICS"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Statistics()))
            },
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.location_on),
              title: const Text("TRACK VEHICLE"),
              onTap: () => { Navigator.push(context,MaterialPageRoute(builder: (context)=> AdminDriverListForTracking())),
              }
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.propane_tank),
              title: const Text("FUEL MONITORING"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FuelDetection()))
            },
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.chat),
              title: const Text("CHAT"),
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>const TopNavBar()))
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.help),
              title: const Text("HELP"),
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=> AdminSettings()))
          ),
          ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(Icons.power_settings_new_outlined),
              title: const Text("LOGOUT"),
              onTap: () async{

                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> FooPage()));

              }
          )
    ],
    ),
    );
    }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
    );
  }
}
