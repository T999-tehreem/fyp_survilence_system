import 'package:flutter/cupertino.dart';

class NotificationModel {
  String? Username;
  String? Notificationtitle;
  String? Notificationdescription;
  String? officerName;

  NotificationModel({this.Username, this.Notificationtitle, this.Notificationdescription,this.officerName});
  factory NotificationModel.fromMapNotificationOfficer(map){
    return NotificationModel(
        Username:map['Username'],
        Notificationtitle:map['Notificationtitle'],
        Notificationdescription:map['Notificationdescription'],
        officerName:map['officerName']
    );
  }
  factory NotificationModel.fromMapNotification(map){
    return NotificationModel(
        Username:map['Username'],
        Notificationtitle:map['Notificationtitle'],
        Notificationdescription:map['Notificationdescription']
    );
  }
  Map<String, dynamic> toMapNotification() {
    return {
      'Username': Username,
      'Notificationtitle': Notificationtitle,
      'Notificationdescription': Notificationdescription
    };
  }
  Map<String, dynamic> toMapNotificationOfficer() {
    return {
      'officerName':officerName,
      'Username': Username,
      'Notificationtitle': Notificationtitle,
      'Notificationdescription': Notificationdescription
    };
  }
}