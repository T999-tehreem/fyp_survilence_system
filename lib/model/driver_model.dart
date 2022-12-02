class DriverModel {
  String? driverId;
  String? name;
  String? email;
  String? phoneno;
  String? cnic;
  String? drivingrank;
  String? password;
  String? address;
  String? profileImage;

  DriverModel({this.driverId, this.name, this.email, this.phoneno, this.cnic,
    this.drivingrank, this.address, this.password, this.profileImage});
  factory DriverModel.fromMapDriver(map){
    return DriverModel(
        driverId:map['driverId'],
        name:map['name'],
        email:map['email'],
        phoneno:map['phoneno'],
        cnic:map['cnic'],
        drivingrank:map['drivingrank'],
        address:map['address'],
        password:map['password'],
        profileImage:map['profileImage'],
    );
  }
  Map<String, dynamic> toMapDriver() {
    return {
      'driverId': driverId,
      'name': name,
      'email': email,
      'phoneno': phoneno,
      'cnic': cnic,
      'drivingrank': drivingrank,
      'address': address,
      'password': password,
      'profileImage': profileImage,
    };
  }
}