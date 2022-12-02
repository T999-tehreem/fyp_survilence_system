class ChallanModel {
  String? Challan_no;
  String? challan_driver_name;
  String? challan_driver_rank;
  String? challan_vehicle_no;
  String? challan_time;
  String? challan_day;
  String? challan_date;
  String? challan_month;
  String? challan_year;
  String? challan_type;
  String? challan_description;
  String? challan_fine;

  ChallanModel({this.Challan_no, this.challan_driver_name,
    this.challan_driver_rank,this.challan_vehicle_no,
    this.challan_time, this.challan_day, this.challan_date, this.challan_month, this.challan_year, this.challan_type,this.challan_description,this.challan_fine});

  factory ChallanModel.fromMapChallan(map){
    return ChallanModel(
        Challan_no:map['Challan_no'],
        challan_driver_name:map['challan_driver_name'],
        challan_driver_rank:map['challan_driver_rank'],
        challan_vehicle_no:map['challan_vehicle_no'],
        challan_time:map['challan_time'],
        challan_date:map['challan_date'],
        challan_day:map['challan_day'],
        challan_month:map['challan_month'],
        challan_year:map['challan_year'],
        challan_type:map['challan_type'],
        challan_description:map['challan_description'],
        challan_fine:map['challan_fine']);

  }
  Map<String, dynamic> toMapChallan() {
    return {
      'Challan_no':Challan_no,
      'challan_driver_name':challan_driver_name,
      'challan_driver_rank':challan_driver_rank,
      'challan_vehicle_no':challan_vehicle_no,
      'challan_time':challan_time,
      'challan_day':challan_day,
      'challan_date':challan_date,
      'challan_month':challan_month,
      'challan_year':challan_year,
      'challan_type':challan_type,
      'challan_description':challan_description,
      'challan_fine':challan_fine,
    };
  }
}