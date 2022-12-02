import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {  
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Ringtone player'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('playAlarm'),
                  onPressed: () {
                    FlutterRingtonePlayer.playAlarm();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('playAlarm asAlarm: false'),
                  onPressed: () {
                    FlutterRingtonePlayer.playAlarm(asAlarm: false);
                  },
                ),
              ),

            ],
          ),
        ),
    );
  }

}