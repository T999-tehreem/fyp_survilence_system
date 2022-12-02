class AdminModel {
  String? UserId;
  String? password;

  AdminModel({this.UserId, this.password});
  factory AdminModel.fromMapAdmin(map){
    return AdminModel(
        UserId:map['UserId'],
        password:map['password']);

  }
  Map<String, dynamic> toMapAdmin() {
    return {
      'UserId': UserId,
      'password': password,
    };
  }
}