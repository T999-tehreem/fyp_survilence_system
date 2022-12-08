import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/Challan/ChallanGeneration_by_officer.dart';
import 'package:fyp_survilence_system/screens/Challan/DriversChallanHistory_from_Drivers_side.dart';
import 'package:fyp_survilence_system/screens/Challan/SearchChallanHistory.dart';
import 'package:fyp_survilence_system/screens/Challan/challan.dart';
import 'package:fyp_survilence_system/screens/Challan/DriverChallanDetails.dart';
import 'package:fyp_survilence_system/screens/Fuel_detection.dart';
import 'package:fyp_survilence_system/screens/Notifications/DriverScheduleNotifictaion.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/Utils/notifications.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/controllers/MenuController.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/DriverDummyDashboard.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/allDriversInfo.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverSignup.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/addnewDriver.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/TrafficPoliceOperator/TPdetail/UpdatePoliceOfficerProfile.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/TrafficPoliceOperator/TPdetail/addpoliceofficer.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/TrafficPoliceOperator/allTPInfo.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/dashboard_screen.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/main/side_menu.dart';
import 'package:fyp_survilence_system/screens/TPOfficer/officerdashboard.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/statistics.dart';
import 'package:fyp_survilence_system/screens/alarm.dart';
import 'package:fyp_survilence_system/screens/camera/camera_screen.dart';
import 'package:fyp_survilence_system/screens/camera/detect.dart';
import 'package:fyp_survilence_system/screens/camera/home_page.dart';
import 'package:fyp_survilence_system/screens/camera/screenshot.dart';
import 'package:fyp_survilence_system/screens/chat/DriverChatListforAdmin.dart';
import 'package:fyp_survilence_system/screens/chat/DriverMessageScreen.dart';
import 'package:fyp_survilence_system/screens/chat/OfficerChatListforAdmin.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/nav_bar.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/main/main_screen.dart';
import 'package:fyp_survilence_system/screens/authentication/AdminLogin.dart';
import 'package:fyp_survilence_system/screens/authentication/ForgetPassword.dart';
import 'package:fyp_survilence_system/screens/authentication/DriverLogin.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/Driver/driverdetail/UpdateDriverProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/Admin_settings_Screen.dart';
import 'package:fyp_survilence_system/screens/help_and_guide/settings.dart';
import 'package:fyp_survilence_system/screens/Notifications/NotificationListScreen.dart';
import 'package:fyp_survilence_system/screens/payment/StripePayment.dart';
import 'package:fyp_survilence_system/screens/chat/chatTopNavBar.dart';
import 'package:fyp_survilence_system/screens/payment/home_screen.dart';
import 'package:fyp_survilence_system/screens/payment/login_screen.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/AssignRoutes.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/UpdateRoutes.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/allRoutesInfo.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/tracking/AdminsideDriverListfortracking.dart';
import 'package:fyp_survilence_system/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51LkMxXLNRgnILJXEa9W8Omf1WOmxGYNb1HiwtW0wmUdDrWPQwgogfBrAQP8PNcPACm7PtxoKTvrmbxQa1K2LlCcA00aCuQ6ZNm";
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FYP',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
             ),
      home: FooPage(),

    );
  }
}

class AdminMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondary_Color,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),

        ],
        child: MainScreen(),
      ),
    );
  }
}