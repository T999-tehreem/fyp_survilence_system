class OfficerModel {
  String? OfficerName;
  String? officer_id;
  String? off_id;
  String? phoneno;
  String? address;
  String? rank;
  String? password;
  String? serviceStation;
  String? gender;

  OfficerModel({this.OfficerName, this.officer_id, this.off_id, this.phoneno, this.address,
    this.rank, this.password,this.gender, this.serviceStation});
  factory OfficerModel.fromMapOfficer(map){
    return OfficerModel(
        OfficerName:map['Officername'],
        officer_id:map['Email_ID'],
        off_id:map['Officer_ID'],
        phoneno:map['phoneno'],
        address:map['address'],
        rank:map['rank'],
        password:map['password'],
        gender:map['gender'],
        serviceStation:map['serviceStation']
    );
  }
  Map<String, dynamic> toMapOfficer() {
    return {
      'Officername': OfficerName,
      'officer_id': officer_id,
      'off_id': off_id,
      'phoneno': phoneno,
      'address': address,
      'rank': rank,
      'password': password,
      'gender': gender,
      'serviceStation': serviceStation
    };
  }
}