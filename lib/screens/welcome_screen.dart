import 'dart:async';
import 'dart:math' as math;
import 'package:fyp_survilence_system/screens/LoginChoice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/color.dart';
const colorizeColors = [
  Color(0xB00B679B),
  Color(0xB821FFDE),
  Color(0xffAFE1AF),
  Color(0x368CF4FF),
];

const colorizeTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Horizon',
);
class FooPage extends StatefulWidget {
  const FooPage({Key? key}) : super(key: key);

  @override
  State<FooPage> createState() => _FooPageState();
}

class _FooPageState extends State<FooPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 3))
    ..repeat();

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 4),
            () =>
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginChoice())));

    return Scaffold(
      body: Center(

        child: SingleChildScrollView( child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white54,
                backgroundImage: AssetImage(
                  'assets/justwheel.PNG',
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SizedBox(

                child: ( DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40.0,
                    color: welcome_color,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText('Accident Prevention', textStyle: colorizeTextStyle,
                        colors: colorizeColors,),
                    ],          isRepeatingAnimation: true,
                  ),
                )
                ),),

            ), const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: SizedBox(

                child: ( DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40.0,
                    color: welcome_color,
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText('System', textStyle: colorizeTextStyle,
                        colors: colorizeColors,),
                    ],          isRepeatingAnimation: true,
                  ),
                )
                ),),

            ),

            /* Text(
                'Accident Prevention System',
                style: GoogleFonts.lobster(fontSize: 30, color: welcome_color),
              ),*/
          ],
        ),
        ),


      ),
    );
  }
}